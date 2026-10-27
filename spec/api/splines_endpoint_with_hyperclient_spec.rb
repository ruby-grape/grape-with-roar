require 'spec_helper'

describe Acme::Api::SplinesEndpoint do
  def app
    Acme::App.instance
  end

  let(:client) do
    Hyperclient.new('http://example.org/api') do |client|
      client.connection(default: false) do |conn|
        conn.request :hal_json
        conn.response :hal_json, content_type: /\bjson$/
        conn.adapter Faraday::Adapter::Rack, app
      end
    end
  end

  context 'when following the README example' do
    it 'creates, updates, and deletes through HAL self links' do
      spline = client.splines._post(spline: { reticulated: true })
      expect(spline.reticulated).to be true
      spline = spline._put(spline: { reticulated: false })
      expect(spline.reticulated).to be false
      expect(Acme::Models::Spline.find(spline.id).reticulated).to be false
      expect(spline._delete._status).to eq 200
      expect(Acme::Models::Spline.all.count).to eq 0
    end

    it 'expands a fresh collection after creating a spline' do
      client.splines._post(spline: { reticulated: true })
      expect(client.splines(size: 2).count).to eq 1
    end
  end

  context 'when creating multiple splines' do
    before do
      [true, false, true].each_with_index do |reticulated, index|
        client.splines._post(spline: { name: index.to_s, reticulated: reticulated })
      end
    end

    it 'lists persisted names and booleans across pages' do
      splines = client.splines(size: 2)
      expect(splines.map { |spline| [spline.name, spline.reticulated] }).to contain_exactly(
        ['0', true], ['1', false], ['2', true]
      )
    end

    it 'deletes the listed splines' do
      client.splines({}).each(&:_delete)
      expect(Acme::Models::Spline.count).to eq 0
    end
  end

  context 'splines' do
    before do
      3.times do
        Fabricate(:acme_models_spline)
      end
    end

    it 'returns all splines by default' do
      expect(client.splines({}).count).to eq 3
    end

    it 'returns all splines paginating by 2' do
      expect(client.splines(size: 2).count).to eq 3
    end

    it 'returns pagination' do
      response = client.splines(size: 2)
      expect(response._links.self._url).to eq 'http://example.org/api/splines?size=2'
      expect(response._links.next._url).to match(%r{^http://example.org/api/splines\?cursor=.*size=2$})
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
      expect(spline.id).not_to be_blank
      expect(spline.reticulated).to be true
    end

    it 'updates a spline' do
      spline = client.spline(id: spline1.id)._put(spline: { reticulated: true })
      expect(spline.id).to eq spline1.id.to_s
      expect(spline.reticulated).to be true
    end

    it 'deletes a spline' do
      spline = client.spline(id: spline1.id)._delete
      expect(spline.id).to eq spline1.id.to_s
    end

    it 'returns a spline' do
      spline = client.spline(id: spline1.id)
      expect(spline.id).to eq spline1.id.to_s
      # TODO: we should be able to expand the curie on spline._links['images:thumbnail']
      expect(spline._links._curies['images'].expand('thumbnail')).to eq 'http://example.org/docs/splines/images/thumbnail'
      expect(spline._links['images:thumbnail']._url).to eq "http://example.org/api/splines/#{spline1.id}/images/thumbnail.jpg"
    end
  end
end
