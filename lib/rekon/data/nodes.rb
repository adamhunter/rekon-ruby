require 'timeout'

module Rekon
  module Data
    class Nodes
      include Ripple::Document
      
      property :buckets, Array, :default => []
      
      before_create :sync_buckets
      
      def self.bucket_name
        'rekon_app_nodes'
      end
      
      def name
        key
      end
      
      def timeout_length
        3
      end
            
      def sync_buckets
        self.buckets = begin
          Timeout.timeout(timeout_length) { client.buckets.map(&:name) rescue [] }
        rescue Timeout::Error => e
          []
        end
        
      end
      
      def ping
        begin
          Timeout.timeout(timeout_length) { client.http.ping }
        rescue Timeout::Error => e
          nil
        end
      end
      
      def status
        case ping
        when true
          'online'
        when false
          'offline'
        when nil
          'timeout'
        end
      end
      
      def stats
        client.http.stats
      end
      
      def client
        host, port = name.split(':')
        @client ||= Riak::Client.new(:host => host, :port => port.to_i, :http_backend => :Excon)
      end
            
    end
  end
end