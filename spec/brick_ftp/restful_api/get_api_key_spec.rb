# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetAPIKey, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return User API key object' do
        expected_user_api_key = BrickFTP::Types::UserAPIKey.new(
          id: 12_345,
          name: 'test',
          permission_set: 'full',
          platform: 'none',
          expires_at: nil,
          created_at: '2018-08-17T08:16:52-04:00'
        )

        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/api_keys/12345.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: expected_user_api_key.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetAPIKey.new(rest)

        expect(command.call(12_345)).to eq(expected_user_api_key)
      end
    end

    context 'API key not found' do
      it 'raise exception' do
        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/api_keys/1234.json')
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
