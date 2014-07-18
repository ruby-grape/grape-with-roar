module Acme
  module Api
    class RootEndpoint < Grape::API
      prefix 'api'
      format :json
      formatter :json, Grape::Formatter::Roar

      desc 'Acme Reticulated Splines Api.'
      get do
        {
          splines_url: "#{request.url}/splines"
        }
      end

      mount Acme::Api::SplinesEndpoint

      add_swagger_documentation api_version: 'v1'
    end
  end
end
