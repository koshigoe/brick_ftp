# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreatePublicKey, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created User Public key object' do
        created_public_key = BrickFTP::Types::UserPublicKey.new(
          id: 12_345,
          title: 'test',
          fingerprint: 'finger-pring',
          created_at: '2018-08-17T08:16:52-04:00'
        )

        stub_request(:post, 'https://subdomain.brickftp.com/api/rest/v1/users/1234/public_keys.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { title: 'mykey' }.to_json
          )
          .to_return(body: created_public_key.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreatePublicKey::Params.new(title: 'mykey')
        command = BrickFTP::RESTfulAPI::CreatePublicKey.new(rest)

        expect(command.call(1234, params)).to eq created_public_key
      end
    end
  end
end
