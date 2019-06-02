# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateAPIKey, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created User API key object' do
        created_api_key = BrickFTP::Types::UserAPIKey.new(
          id: 12_345,
          key: 'api-key',
          name: 'mykey',
          permission_set: 'full',
          platform: 'none',
          expires_at: nil,
          created_at: '2018-08-17T00:00:00Z'
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/users/1234/api_keys.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { name: 'mykey' }.to_json
          )
          .to_return(body: created_api_key.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateAPIKey::Params.new(name: 'mykey')
        command = BrickFTP::RESTfulAPI::CreateAPIKey.new(rest)

        expect(command.call(1234, params)).to eq created_api_key
      end
    end
  end
end
