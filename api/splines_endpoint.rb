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

        desc 'Create a spline.'
        params do
          requires :spline, type: Hash do
            optional :reticulated, type: Boolean, default: false
          end # Acme::Api::Presenters::SplinePresenter
        end
        post do
          spline = create Acme::Models::Spline, with: Acme::Api::Presenters::SplinePresenter, from: params[:spline]
          present spline, with: Acme::Api::Presenters::SplinePresenter
        end

        desc 'Update an existing spline.'
        params do
          requires :uuid, type: String, desc: 'Spline id.'
          requires :spline, type: Hash do
            optional :reticulated, type: Boolean, default: false
          end # Acme::Api::Presenters::SplinePresenter
        end
        put ':uuid' do
          spline = Acme::Models::Spline.find(params[:uuid])
          update spline, with: Acme::Api::Presenters::SplinePresenter, from: params[:spline]
        end

        desc 'Delete an existing spline.'
        params do
          requires :uuid, type: String, desc: 'Spline id.'
        end
        delete ':uuid' do
          spline = Acme::Models::Spline.find(params[:uuid])
          delete spline, with: Acme::Api::Presenters::SplinePresenter
        end

        desc 'Get all the splines.'
        params do
          optional :page, type: Integer, default: 1, desc: 'Page of splines to return.'
          optional :size, type: Integer, default: 3, desc: 'Number of splines to return.'
        end
        get do
          splines = Acme::Models::Spline.all
          present Kaminari.paginate_array(splines).page(params[:page]).per(params[:size]), with: Acme::Api::Presenters::SplinesPresenter
        end
      end
    end
  end
end
