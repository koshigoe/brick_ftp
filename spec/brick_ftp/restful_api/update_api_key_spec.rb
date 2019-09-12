# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::UpdateApiKey, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return updated API key object' do
        updated_api_key = BrickFTP::Types::ApiKey.new(
          id: 1,
          created_at: '2000-01-01 01:00:00 UTC',
          expires_at: '2000-01-01 01:00:00 UTC',
          key: '[key]',
          name: 'My Main API Key',
          permission_set: 'full',
          platform: 'win32',
          user_id: 1
        )

        stub_request(:patch, 'https://subdomain.files.com/api/rest/v1/api_keys/1.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              name: 'My Key',
              permission_set: 'full',
              expires_at: '2000-01-01 01:00:00 UTC',
            }.to_json
          )
          .to_return(body: updated_api_key.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::UpdateApiKey::Params.new(
          id: 1,
          name: 'My Key',
          permission_set: 'full',
          expires_at: '2000-01-01 01:00:00 UTC'
        )
        command = BrickFTP::RESTfulAPI::UpdateApiKey.new(rest)

        expect(command.call(params)).to eq updated_api_key
      end
    end
  end
end
