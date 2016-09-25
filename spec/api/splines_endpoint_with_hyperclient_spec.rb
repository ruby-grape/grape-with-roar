require 'spec_helper'

describe Acme::Api::SplinesEndpoint do
  def app
    Acme::App.instance
  end

  let(:client) do
    Hyperclient.new('http://example.org/api') do |client|
      client.headers['Content-Type'] = 'application/json'
      client.connection(default: false) do |conn|
        conn.request :json
        conn.response :json
        conn.use Faraday::Adapter::Rack, app
      end
    end
  end

  context 'splines' do
    before(:each) do
      3.times do
        Fabricate(:acme_models_spline)
      end
    end

    it 'returns 3 splines by default' do
      expect(client.splines({}).count).to eq 3
    end

    it 'returns 2 splines' do
      expect(client.splines(size: 2).count).to eq 2
    end

    it 'returns pagination' do
      response = client.splines(size: 2, page: 2)
      expect(response._links.next._url).to eq 'http://example.org/api/splines?page=3&size=2'
      expect(response._links.prev._url).to eq 'http://example.org/api/splines?page=1&size=2'
      expect(response._links.self._url).to eq 'http://example.org/api/splines?page=2&size=2'
    end

    it 'returns all unique ids' do
      splines = client.splines({})
      expect(splines.map(&:id).uniq.count).to eq 3
    end
  end

  context 'spline' do
    let(:spline1) { Fabricate(:acme_models_spline) }

    it 'creates a spline' do
      spline = client.splines._post(spline: { reticulated: true })
      expect(spline.id).to_not be_blank
      expect(spline.reticulated).to be true
    end

    it 'updates a spline' do
      spline = client.spline(id: spline1.id)._put(spline: { reticulated: true })
      expect(spline.id).to eq spline1.id
      expect(spline.reticulated).to be true
    end

    it 'deletes a spline' do
      spline = client.spline(id: spline1.id)._delete
      expect(spline.id).to eq spline1.id
    end

    it 'returns a spline' do
      spline = client.spline(id: spline1.id)
      expect(spline.id).to eq spline1.id
      # TODO: we should be able to expand the curie on spline._links['images:thumbnail']
      expect(spline._links._curies['images'].expand('thumbnail')).to eq 'http://example.org/docs/splines/images/thumbnail'
      expect(spline._links['images:thumbnail']._url).to eq "http://example.org/api/splines/#{spline1.id}/images/thumbnail.jpg"
    end
  end
end
