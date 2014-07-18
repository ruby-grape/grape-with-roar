require 'presenters/paginated_presenter'

module Acme
  module Api
    module Presenters
      module SplinesPresenter
        include Grape::Roar::Representer
        include Roar::Representer::JSON::HAL
        include Roar::Representer::Feature::Hypermedia
        include Acme::Api::Presenters::PaginatedPresenter

        collection :to_a, extend: SplinePresenter, as: :splines, embedded: true
      end
    end
  end
end
