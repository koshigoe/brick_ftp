# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetPublicKey, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Public key object' do
        expected_public_key = BrickFTP::Types::PublicKey.new(
          id: 1,
          created_at: '2000-01-01 01:00:00 UTC',
          fingerprint: '43:51:43:a1:b5:fc:8b:b7:0a:3a:a9:b1:0f:66:73:a8',
          title: 'My public key'
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/public_keys/1.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: expected_public_key.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetPublicKey.new(rest)

        expect(command.call(id: 1)).to eq(expected_public_key)
      end
    end

    context 'Public key not found' do
      it 'raise exception' do
        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/public_keys/1.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '[]', status: 404)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetPublicKey.new(rest)

        expect { command.call(id: 1) }.to raise_error(BrickFTP::RESTfulAPI::Client::Error)
      end
    end
  end
end
