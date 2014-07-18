require 'spec_helper'

describe Acme::Api::RootEndpoint do
  include Rack::Test::Methods

  def app
    Acme::App.instance
  end

  it 'hypermedia root' do
    get '/api'
    expect(last_response.status).to eq 200
    expect(JSON.parse(last_response.body)).to eq(
      'splines_url' => 'http://example.org/api/splines'
    )
  end
  it 'follows all links' do
    get '/api'
    expect(last_response.status).to eq 200
    json = JSON.parse(last_response.body)
    json.each_pair do |_key, url|
      url = url.gsub('http://exaple.org/', '/')
      get url
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to_not eq({})
    end
  end
end
