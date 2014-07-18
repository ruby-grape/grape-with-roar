module Acme
  module Api
    module Presenters
      module SplinePresenter
        include Roar::Representer::JSON::HAL
        include Roar::Representer::Feature::Hypermedia
        include Grape::Roar::Representer

        property :uuid
        property :reticulated

        link :self do |opts|
          request = Grape::Request.new(opts[:env])
          "#{request.base_url}/api/splines/#{uuid}"
        end
      end
    end
  end
end
