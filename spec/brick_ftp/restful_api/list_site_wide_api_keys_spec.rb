# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListSiteWideApiKeys, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of site-wide API key object' do
        expected_user_api_key = BrickFTP::Types::ApiKey.new(
          id: 1,
          created_at: '2000-01-01 01:00:00 UTC',
          expires_at: '000-01-01 01:00:00 UTC',
          key: '[key]',
          name: 'My Main API Key',
          permission_set: 'full',
          platform: 'win32',
          user_id: 1
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/site/api_keys.json?with_users=true')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_user_api_key.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListSiteWideApiKeys.new(rest)

        expect(command.call(with_users: true)).to eq([expected_user_api_key])
      end
    end
  end
end
