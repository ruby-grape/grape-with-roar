module Acme
  module Api
    class SplinesEndpoint < Grape::API
      format :json

      namespace :splines do
        desc 'Get a spline.'
        params do
          requires :uuid, type: String, desc: 'Spline id.'
        end
        get ':uuid' do
          spline = Acme::Models::Spline.new(uuid: params[:uuid])
          present spline, with: Acme::Api::Presenters::SplinePresenter
        end

        desc 'Get all the splines.'
        params do
          optional :page, type: Integer, default: 1, desc: 'Number of splines to return.'
          optional :size, type: Integer, default: 3, desc: 'Number of splines to return.'
        end
        get do
          splines = 42.times.map { Acme::Models::Spline.new }
          present Kaminari.paginate_array(splines).page(params[:page]).per(params[:size]), with: Acme::Api::Presenters::SplinesPresenter
        end
      end
    end
  end
end
