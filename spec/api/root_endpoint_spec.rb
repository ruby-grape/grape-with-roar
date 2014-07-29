require 'spec_helper'

describe Acme::Api::RootEndpoint do
  include Rack::Test::Methods

  def app
    Acme::App.instance
  end

  it 'hypermedia root' do
    get '/api'
    expect(last_response.status).to eq 200
    links = JSON.parse(last_response.body)['_links']
    expect(links.keys).to eq(%w(self swagger_doc splines))
  end
  it 'follows all links' do
    get '/api'
    expect(last_response.status).to eq 200
    links = JSON.parse(last_response.body)['_links']
    links.each_pair do |_key, h|
      get h['href'].gsub('http://example.org', '')
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to_not eq({})
    end
  end
end
