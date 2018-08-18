# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListAPIKeys, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of User API key object' do
        expected_user_api_key = BrickFTP::Types::UserAPIKey.new(
          id: 12_345,
          name: 'test',
          permission_set: 'full',
          platform: 'none',
          expires_at: nil,
          created_at: '2018-08-17T08:16:52-04:00'
        )

        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/users/1234/api_keys.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_user_api_key.to_h].to_json)

        rest = BrickFTP::REST.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListAPIKeys.new(rest)
        users = command.call(1234)

        expect(users).to eq([expected_user_api_key])
      end
    end
  end
end
