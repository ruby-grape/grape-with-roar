require 'spec_helper'

describe Acme::Api::SplinesEndpoint do
  def app
    Acme::App.instance
  end

  let(:client) do
    Hyperclient.new('http://example.org/api') do |client|
      client.connection(default: false) do |conn|
        conn.response :json
        conn.use Faraday::Adapter::Rack, app
      end
    end
  end

  context 'splines' do
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

    it 'returns all unique uuids' do
      splines = client.splines({})
      expect(splines.map { |spline| spline.uuid }.uniq.count).to eq 3
    end
  end

  context 'spline' do
    it 'returns a spline' do
      spline = client.spline(uuid: '123')
      expect(spline.uuid).to eq '123'
      expect(spline._links['images:thumbnail']._url).to eq 'http://example.org/api/splines/123/images/thumbnail.jpg'
    end
  end
end
