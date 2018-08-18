# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListPublicKeys, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of User Public key object' do
        expected_user_public_key = BrickFTP::Types::UserPublicKey.new(
          id: 12_345,
          title: 'test',
          fingerprint: 'finger-pring',
          created_at: '2018-08-17T08:16:52-04:00'
        )

        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/users/1234/public_keys.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_user_public_key.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListPublicKeys.new(rest)
        users = command.call(1234)

        expect(users).to eq([expected_user_public_key])
      end
    end
  end
end
