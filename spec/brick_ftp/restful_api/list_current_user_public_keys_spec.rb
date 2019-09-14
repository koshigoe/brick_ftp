# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListCurrentUserPublicKeys, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Public key object' do
        expected_user_public_key = BrickFTP::Types::PublicKey.new(
          id: 1,
          created_at: '2000-01-01 01:00:00 UTC',
          fingerprint: '43:51:43:a1:b5:fc:8b:b7:0a:3a:a9:b1:0f:66:73:a8',
          title: 'My public key'
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/user/public_keys.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_user_public_key.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListCurrentUserPublicKeys.new(rest)

        expect(command.call).to eq([expected_user_public_key])
      end
    end
  end
end
