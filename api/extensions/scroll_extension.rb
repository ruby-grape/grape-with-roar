module Grape
  module Extensions
    module ScrollExtension
      # apply cursor-based pagination to a collection
      # returns a hash:
      #   results: (paginated collection subset)
      #   next: (cursor to the next page)
      def paginate_by_cursor(coll, &_block)
        results = { results: [], next: nil }
        size = (params[:size] || 10).to_i
        # some items may be skipped with a block
        coll.limit(size).scroll(params[:cursor]) do |record, next_cursor|
          results[:results] << record
          results[:next] = next_cursor.to_s
        end
        results
      end

      Grape::Endpoint.send(:include, self)
    end
  end
end
