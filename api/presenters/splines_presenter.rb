require 'presenters/paginated_presenter'
require 'presenters/spline_presenter'

module Acme
  module Api
    module Presenters
      module SplinesPresenter
        include Roar::JSON::HAL
        include Roar::Hypermedia
        include Grape::Roar::Representer
        include Acme::Api::Presenters::PaginatedPresenter

        collection :to_a, extend: SplinePresenter, as: :splines, embedded: true
      end
    end
  end
end
