# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::UpdateCurrentAPIKey, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return updated current API key object' do
        updated_api_key = BrickFTP::Types::APIKey.new(
          id: 1,
          created_at: '2000-01-01 01:00:00 UTC',
          expires_at: '2000-01-01 01:00:00 UTC',
          key: '[key]',
          name: 'My Main API Key',
          permission_set: 'full',
          platform: 'win32',
          user_id: 1
        )

        stub_request(:patch, 'https://subdomain.files.com/api/rest/v1/api_key.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              name: 'My Key',
              permission_set: 'full',
              expires_at: '2000-01-01 01:00:00 UTC'
            }.to_json
          )
          .to_return(body: updated_api_key.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::UpdateCurrentAPIKey::Params.new(
          name: 'My Key',
          permission_set: 'full',
          expires_at: '2000-01-01 01:00:00 UTC'
        )
        command = BrickFTP::RESTfulAPI::UpdateCurrentAPIKey.new(rest)

        expect(command.call(params)).to eq updated_api_key
      end
    end
  end
end
