module Acme
  module Api
    module Presenters
      module PaginatedPresenter
        include Roar::JSON::HAL
        include Roar::Hypermedia
        include Grape::Roar::Representer

        link :self do |opts|
          "#{request_url(opts)}#{query_string_for_cursor(nil, opts)}"
        end

        link :next do |opts|
          "#{request_url(opts)}#{query_string_for_cursor(represented[:next], opts)}" if represented.key?(:next)
        end

        private

        def request_url(opts)
          request = Grape::Request.new(opts[:env])
          "#{request.base_url}#{opts[:env]['PATH_INFO']}"
        end

        # replace the page parameter in the query string
        def query_string_for_cursor(cursor, opts)
          qs = Rack::Utils.parse_nested_query(opts[:env]['QUERY_STRING'])
          qs['cursor'] = cursor if cursor
          "?#{qs.to_query}" unless qs.empty?
        end
      end
    end
  end
end
