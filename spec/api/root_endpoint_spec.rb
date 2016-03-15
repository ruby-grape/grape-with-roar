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
    expect(links.keys.sort).to eq(%w(self spline splines swagger_doc))
  end
  it 'follows all links' do
    get '/api'
    expect(last_response.status).to eq 200
    links = JSON.parse(last_response.body)['_links']
    links.each_pair do |_key, h|
      href = h['href']
      next if href.include?('{') # templated link
      get href.gsub('http://example.org', '')
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to_not eq({})
    end
  end
  it 'rewrites encoded HAL links to make them clickable' do
    get '/api/splines/%7B?cursor,size%7D'
    expect(last_response.status).to eq 302
    expect(last_response.headers['Location']).to eq '/api/splines/'
  end
  it 'rewrites encoded HAL links without a trailing slash to make them clickable' do
    get '/api/splines%7B?cursor,size%7D'
    expect(last_response.status).to eq 302
    expect(last_response.headers['Location']).to eq '/api/splines'
  end
end
