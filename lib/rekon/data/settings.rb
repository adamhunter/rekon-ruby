module Rekon
  module Data
    class Settings
      include Ripple::Document
      
      property :hosts, Array, :presence => true
      
      def self.bucket_name
        'rekon_app_settings'
      end
      
      def self.load
        @settings ||= find('settings')
      end
      
      def self.nodes
        @nodes ||= @settings.hosts.map { |host| Rekon::Data::Nodes.find(host) }.compact
      end
      
      def self.clear_nodes
        @nodes = nil
      end
      
      def self.destroy
        load.destroy
        @settings = nil
      end
      
    end
  end
end