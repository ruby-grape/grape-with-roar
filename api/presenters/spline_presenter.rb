module Acme
  module Api
    module Presenters
      module SplinePresenter
        include Roar::JSON::HAL
        include Roar::Hypermedia
        include Grape::Roar::Representer

        property :id_s, as: :id, writeable: false, type: String, desc: 'Spline unique ID.'
        property :name, type: String, desc: 'Spline name.'
        property :reticulated, type: Grape::API::Boolean, default: false, desc: 'True if spline is reticulated.'

        link :self do |opts|
          request = Grape::Request.new(opts[:env])
          "#{request.base_url}/api/splines/#{id_s}"
        end

        curies do |opts|
          request = Grape::Request.new(opts[:env])
          [
            name: :images,
            href: "#{request.base_url}/docs/splines/images/{rel}",
            templated: true
          ]
        end

        link 'images:thumbnail' do |opts|
          request = Grape::Request.new(opts[:env])
          "#{request.base_url}/api/splines/#{id_s}/images/thumbnail.jpg"
        end

        private

        def id_s
          id.to_s
        end
      end
    end
  end
end
