module Rekon
  module App
    module Helpers
      
      def method_put
        %[<input type="hidden" name="_method" value="put" />]
      end
      
      def method_delete
        %[<input type="hidden" name="_method" value="delete" />]
      end
      
      def view_in_riak(url)
        %[<a href="%s" class="riak icon" target="_blank">Riak</a>] % url
      end
      
      def view_in_rekon(url)
        %[<a href="%s" class="view icon">View</a>] % url
      end
      
      def edit_in_rekon(url)
        %[<a href="%s" class="edit icon">Edit</a>] % url
      end
      
      def destroy_in_rekon(action)
        <<-FORM
          <form action="#{action}" method="post">
            #{method_delete}
            <button type="submit" class="delete icon" onclick="return confirm('Are you sure you want to delete this?')">Delete</button>
          </form>
        FORM
      end
      
      def buckets_in_rekon(node)
        %[<a href="%s" class="buckets icon">Buckets</a>] % "/nodes/#{node.name}"
      end
      
      def stats_in_rekon(node)
        %[<a href="%s" class="stats icon">Stats</a>] % "/nodes/#{node.name}/stats"
      end
      
      def pending_spinner(data_function_name, data_arguments='')
        %[<img src="/images/pending.gif" alt="Pending" class="pending" data-function-name="%s" %s />] % [data_function_name, data_arguments]
      end
            
    end
  end
end