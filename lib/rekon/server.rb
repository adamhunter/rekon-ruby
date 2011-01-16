require 'sinatra/base'
require 'haml'
require 'rekon'

module Rekon
  class Server < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"
    set :public, "#{dir}/server/public"
    set :static, true
    
    before do 
      @installed = Rekon::App.install!
      @settings  = Rekon::Data::Settings.load
    end
    
    get '/' do
      haml :index
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
    
    get '/nodes/:host/:bucket' do
      @host    = params[:host]
      @node    = Rekon::Data::Nodes.find!(@host)
      @bucket  = Riak::Bucket.new(Ripple.client, params[:bucket])
      @keys    = @bucket.keys
      haml :bucket
    end
    
    get '/nodes/:host/:bucket/:key' do
      @host    = params[:host]
      @node    = Rekon::Data::Nodes.find!(@host)
      @bucket  = Riak::Bucket.new(Ripple.client, params[:bucket])
      @robject = @bucket.get(params[:key])
      haml :key
    end
    
    get '/stats' do
      @stats = Ripple.client.http.stats
      haml :stats
    end
    
    get '/uninstall' do
      Rekon::App::Installer::uninstall!
      'done'
    end
  end
end