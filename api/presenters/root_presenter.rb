module Acme
  module Api
    module Presenters
      module RootPresenter
        include Roar::JSON::HAL
        include Roar::Hypermedia
        include Grape::Roar::Representer

        link :self do |opts|
          "#{base_url(opts)}/api"
        end

        link :swagger_doc do |opts|
          "#{base_url(opts)}/api/swagger_doc"
        end

        link :splines do |opts|
          {
            href: "#{base_url(opts)}/api/splines{?page,size}",
            templated: true
          }
        end

        link :spline do |opts|
          {
            href: "#{base_url(opts)}/api/splines/{uuid}",
            templated: true
          }
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
