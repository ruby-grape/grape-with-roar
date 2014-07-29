module Acme
  module Api
    class RootEndpoint < Grape::API
      prefix 'api'
      format :json
      formatter :json, Grape::Formatter::Roar

      desc 'Acme Reticulated Splines Api.'
      get do
        present self, with: Acme::Api::Presenters::RootPresenter
      end

      mount Acme::Api::SplinesEndpoint

      add_swagger_documentation api_version: 'v1'
    end
  end
end
