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

        curies do |opts|
          request = Grape::Request.new(opts[:env])
          [
            name: :images,
            href: "#{request.base_url}/api/splines/#{uuid}/images/{rel}",
            templated: true
          ]
        end

        link 'images:thumbnail' do
          'thumbnail.jpg'
        end
      end
    end
  end
end
