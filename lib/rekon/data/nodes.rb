module Rekon
  module Data
    class Nodes
      include Ripple::Document
      
      property :buckets, Array, :default => []
      
      def self.bucket_name
        'rekon_app_nodes'
      end
      
      def name
        key
      end
      
      def sync_buckets
        self.buckets = Ripple.client.buckets.map(&:name)
      end
            
    end
  end
end