module Acme
  module Api
    module Presenters
      module RootPresenter
        include Roar::Representer::JSON::HAL
        include Roar::Representer::Feature::Hypermedia
        include Grape::Roar::Representer

        link :self do |opts|
          "#{base_url(opts)}/api"
        end

        link :swagger_doc do |opts|
          "#{base_url(opts)}/api/swagger_doc"
        end

        link :splines do |opts|
          "#{base_url(opts)}/api/splines"
        end

        private

        def base_url(opts)
          request = Grape::Request.new(opts[:env])
          request.base_url
        end
      end
    end
  end
end
