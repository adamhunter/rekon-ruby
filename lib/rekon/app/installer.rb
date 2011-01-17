module Rekon
  module App
    class Installer
    
      def self.install!
        config = ARGV.first
        Ripple.load_configuration(config) unless config.blank?
        
        settings = Rekon::Data::Settings.new
        settings.key = 'settings'
        settings.hosts = ["#{Ripple.client.host}:#{Ripple.client.port}"]
        settings.save!
        
        nodes = settings.hosts.map do |host|
          node = Rekon::Data::Nodes.new
          node.key = host
          node
        end
        nodes.map(&:save!)
        
        true
      end   
      
      def self.installed?
        !!Rekon::Data::Settings.load
      end
      
      def self.uninstall!
        Rekon::Data::Settings.destroy
        Rekon::Data::Settings.nodes.map(&:destroy)
        true
      end
    end
  end
end