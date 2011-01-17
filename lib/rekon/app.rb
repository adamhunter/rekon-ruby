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

  end
end