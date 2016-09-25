require 'spec_helper'

describe Acme::Api::SplinesEndpoint do
  include Rack::Test::Methods

  def app
    Acme::App.instance
  end

  context 'splines' do
    before(:each) do
      3.times do
        Fabricate(:acme_models_spline)
      end
    end

    it 'returns 3 splines by default' do
      get '/api/splines'
      expect(last_response.status).to eq 200
      json = JSON.parse(last_response.body)
      expect(json['_embedded']['splines'].count).to eq 3
    end

    it 'returns 2 splines' do
      get '/api/splines?size=2'
      expect(last_response.status).to eq 200
      json = JSON.parse(last_response.body)
      expect(json['_embedded']['splines'].count).to eq 2
    end

    it 'returns pagination' do
      get '/api/splines?size=2&page=2'
      expect(last_response.status).to eq 200
      json = JSON.parse(last_response.body)
      expect(json['_links']['next']['href']).to eq 'http://example.org/api/splines?page=3&size=2'
      expect(json['_links']['prev']['href']).to eq 'http://example.org/api/splines?page=1&size=2'
      expect(json['_links']['self']['href']).to eq 'http://example.org/api/splines?page=2&size=2'
    end

    it 'returns all unique ids' do
      get '/api/splines'
      expect(last_response.status).to eq 200
      json = JSON.parse(last_response.body)
      expect(json['_embedded']['splines'].map { |s| s['id'] }.uniq.count).to eq 3
    end
  end

  context 'spline' do
    let(:spline1) { Fabricate(:acme_models_spline) }

    it 'creates a spline' do
      post '/api/splines', spline: { name: 'new name', reticulated: false }
      expect(last_response.status).to eq 201
      json = JSON.parse(last_response.body)
      expect(json['id']).to_not be_blank
      expect(json['name']).to eq 'new name'
    end

    it 'updates a spline' do
      put "/api/splines/#{spline1.id}", spline: { name: 'new name', reticulated: true }
      expect(last_response.status).to eq 200
      json = JSON.parse(last_response.body)
      expect(json['id']).to eq spline1.id
      expect(json['name']).to eq 'new name'
      expect(json['reticulated']).to be true
    end

    it 'deletes a spline' do
      expect_any_instance_of(Acme::Models::Spline).to receive(:destroy)
      delete "/api/splines/#{spline1.id}"
      expect(last_response.status).to eq 200
      json = JSON.parse(last_response.body)
      expect(json['id']).to eq spline1.id
    end

    it 'returns a spline' do
      get "/api/splines/#{spline1.id}"
      expect(last_response.status).to eq 200
      json = JSON.parse(last_response.body)
      expect(json['id']).to eq spline1.id
      expect(json['_links']['self']['href']).to eq "http://example.org/api/splines/#{spline1.id}"
      expect(json['_links']['curies']).to eq([{ 'name' => 'images', 'href' => 'http://example.org/docs/splines/images/{rel}', 'templated' => true }])
      expect(json['_links']['images:thumbnail']['href']).to eq "http://example.org/api/splines/#{spline1.id}/images/thumbnail.jpg"
    end
  end
end
