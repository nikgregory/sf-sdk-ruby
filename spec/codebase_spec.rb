# frozen_string_literal: true

require 'spec_helper'

describe SFRest::Codebase do
  before :each do
    @conn = SFRest.new "http://#{@mock_endpoint}", @mock_user, @mock_pass
  end

  describe '#list' do
    path = '/api/v1/stacks'

    it 'calls the dynamic requests endpoint' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.codebase.list
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'get'
    end
  end
end
