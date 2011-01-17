module Rekon
  module App
    extend ActiveSupport::Autoload
    
    autoload :Helpers
    autoload :Installer
    
    Ripple.client.http_backend = :Excon
    
    def self.installed?
      Rekon::App::Installer.installed?
    end
    
    def self.add_node(options)
      settings = Rekon::Data::Settings.load
      settings.hosts << options[:name]
      settings.hosts.uniq!
      settings.save
      node = Rekon::Data::Nodes.new
      node.key = options[:name]
      Rekon::Data::Settings.clear_nodes
      node.save
    end
    
    def self.remove_node(node_name)
      settings = Rekon::Data::Settings.load
      settings.hosts.delete(node_name)
      settings.save
      Rekon::Data::Settings.clear_nodes
    end
    
    def self.add_bucket(host, bucket)
      raise ArgumentError.new("host and bucket must be provided") if host.blank? || bucket.blank?
      node   = Rekon::Data::Nodes.find!(host)
      node.buckets << bucket
      node.buckets.uniq!
      Rekon::Data::Settings.clear_nodes
      node.save
      bucket = Riak::Bucket.new(node.client, bucket)
    end

  end
end