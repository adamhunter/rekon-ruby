require 'sinatra/base'
require 'haml'
require 'rekon'

module Rekon
  class Server < Sinatra::Base
    
    use Rack::MethodOverride
    
    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"
    set :public, "#{dir}/server/public"
    set :static, true
    
    helpers do
      include Rack::Utils
      include Rekon::App::Helpers
      
      alias_method :h, :escape_html
    end
    
    before do 
      if Rekon::App.installed?
        @settings  = Rekon::Data::Settings.load
        @page      = params[:page].to_i.zero?     ? 1 : params[:page].to_i
        @per_page  = params[:per_page].to_i.zero? ? 1 : params[:per_page].to_i
      else
        redirect '/install' unless request.path_info == '/install'
      end
    end
    
    get '/' do
      redirect '/nodes'
    end
    
    get '/nodes' do
      Rekon::Data::Settings.clear_nodes
      @nodes = Rekon::Data::Settings.nodes
      haml :nodes
    end
    
    post '/nodes' do
      Rekon::App.add_node(params[:node])
      redirect '/nodes'
    end
    
    delete '/nodes/:host' do
      Rekon::App.remove_node(params[:host])
      redirect '/nodes'
    end
    
    post '/nodes/:host' do
      @bucket = Rekon::App.add_bucket(params[:host], params[:bucket])
      redirect "/nodes/#{params[:host]}/#{@bucket.name}"
    end
    
    get '/nodes/:host' do
      @host    = params[:host]
      @node    = Rekon::Data::Nodes.find!(@host)
      @buckets = @node.buckets
      haml :node
    end
    
    get '/nodes/:host/reload-buckets' do
      @host    = params[:host]
      @node    = Rekon::Data::Nodes.find!(@host)
      @node.sync_buckets
      @node.save!
      redirect "/nodes/#{@host}"
    end
    
    get '/nodes/:host/stats' do
      @host  = params[:host]
      @node  = Rekon::Data::Nodes.find!(@host)
      begin
        @stats = @node.stats
      rescue => e
        return "Error Fetching Stats. #{e.message}"
      end
      haml :stats
    end
    
    get '/nodes/:host/ping' do
      @host = params[:host]
      @node = Rekon::Data::Nodes.find!(@host)
      @node.status
    end
    
    get '/nodes/:host/:bucket' do
      @host    = params[:host]
      @node    = Rekon::Data::Nodes.find!(@host)
      @bucket  = Riak::Bucket.new(@node.client, params[:bucket])
      @keys    = @bucket.keys
      @props   = @bucket.props.with_indifferent_access
      haml :bucket
    end
    
    get '/nodes/:host/:bucket/:key' do
      @host    = params[:host]
      @node    = Rekon::Data::Nodes.find!(@host)
      @bucket  = Riak::Bucket.new(@node.client, params[:bucket])
      @robject = @bucket.get(params[:key])
      haml :key
    end
    
    get '/nodes/:host/:bucket/:key/edit' do
      @host    = params[:host]
      @node    = Rekon::Data::Nodes.find!(@host)
      @bucket  = Riak::Bucket.new(@node.client, params[:bucket])
      @robject = @bucket.get(params[:key])
      haml :key_edit
    end
    
    post '/nodes/:host/:bucket' do
      @host    = params[:host]
      @node    = Rekon::Data::Nodes.find!(@host)
      @bucket  = Riak::Bucket.new(@node.client, params[:bucket])
      @key     = params[:key]
      
      halt 422, 'Key already exists' if params[:key].present? && @bucket.exists?(params[:key])

      @robject = Riak::RObject.new(@bucket, params[:key].presence)
      @robject.content_type = 'application/json'
      @robject.raw_data = {}.to_json
      @robject.store
      redirect "/nodes/#{@host}/#{@bucket.name}/#{@robject.key}/edit"
    end
    
    put '/nodes/:host/:bucket/:key' do
      @host    = params[:host]
      @node    = Rekon::Data::Nodes.find!(@host)
      @bucket  = Riak::Bucket.new(@node.client, params[:bucket])
      @robject = @bucket.get(params[:key])
      @robject.raw_data = JSON.parse(params[:value]).to_json
      @robject.store
      redirect "/nodes/#{@host}/#{@bucket.name}/#{@robject.key}"
    end
    
    delete '/nodes/:host/:bucket/:key' do
      @host    = params[:host]
      @node    = Rekon::Data::Nodes.find!(@host)
      @bucket  = Riak::Bucket.new(@node.client, params[:bucket])
      @bucket.delete(params[:key])
      redirect "/nodes/#{@host}/#{@bucket.name}"
    end
    
    get '/install' do
      Rekon::App::Installer::install!
      redirect '/'
    end
    
    get '/uninstall' do
      Rekon::App::Installer::uninstall!
      'uninstalled...'
    end
    
  end
end