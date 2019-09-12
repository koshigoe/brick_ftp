# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetAPIKey, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return API key object' do
        expected_api_key = BrickFTP::Types::APIKey.new(
          id: 1,
          created_at: '2000-01-01 01:00:00 UTC',
          expires_at: '2000-01-01 01:00:00 UTC',
          key: '[key]',
          name: 'My Main API Key',
          permission_set: 'full',
          platform: 'win32',
          user_id: 1
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/api_keys/12345.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: expected_api_key.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetAPIKey.new(rest)

        expect(command.call(12_345)).to eq(expected_api_key)
      end
    end

    context 'API key not found' do
      it 'raise exception' do
        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/api_keys/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '[]', status: 404)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetAPIKey.new(rest)

        expect { command.call(1234) }.to raise_error(BrickFTP::RESTfulAPI::Client::Error)
      end
    end
  end
end
