require 'spec_helper'

describe Acme::Api::SplinesEndpoint do
  include Rack::Test::Methods

  def app
    Acme::App.instance
  end

  context 'splines' do
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

    it 'returns all unique uuids' do
      get '/api/splines'
      expect(last_response.status).to eq 200
      json = JSON.parse(last_response.body)
      expect(json['_embedded']['splines'].map { |s| s['uuid'] }.uniq.count).to eq 3
    end
  end

  context 'spline' do
    it 'creates a spline' do
      post '/api/splines'
      expect(last_response.status).to eq 201
      json = JSON.parse(last_response.body)
      expect(json['uuid']).to_not be_blank
    end

    it 'updates a spline' do
      put '/api/splines/123?reticulated=true'
      expect(last_response.status).to eq 200
      json = JSON.parse(last_response.body)
      expect(json['uuid']).to eq '123'
      expect(json['reticulated']).to be true
    end

    it 'deletes a spline' do
      delete '/api/splines/123'
      expect(last_response.status).to eq 200
      json = JSON.parse(last_response.body)
      expect(json['uuid']).to eq '123'
    end

    it 'returns a spline' do
      get '/api/splines/123'
      expect(last_response.status).to eq 200
      json = JSON.parse(last_response.body)
      expect(json['uuid']).to eq '123'
      expect(json['_links']['self']['href']).to eq 'http://example.org/api/splines/123'
      expect(json['_links']['curies']).to eq([{ 'name' => 'images', 'href' => 'http://example.org/api/splines/123/images/{rel}', 'templated' => true }])
      expect(json['_links']['images:thumbnail']['href']).to eq 'thumbnail.jpg'
    end
  end
end
