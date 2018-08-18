# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetFileInBundle, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return FileInBundle object' do
        expected_bundle_file = BrickFTP::Types::FileInBundle.new(
          path: 'a/b',
          type: 'file',
          size: 842_665,
          download_uri: 'https://s3.amazonaws.com/objects.brickftp.com/metadata/10099/2e2376c0-7527-0133-21fb-0a2d4abb99a7?..'
        )

        stub_request(:post, 'https://subdomain.brickftp.com/api/rest/v1/bundles/download.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { code: 'a', path: 'a/b', password: 'p' }.to_json
          )
          .to_return(body: expected_bundle_file.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetFileInBundle.new(rest)
        params = BrickFTP::RESTfulAPI::GetFileInBundle::Params.new(code: 'a', path: 'a/b', password: 'p')

        expect(command.call(params)).to eq(expected_bundle_file)
      end
    end
  end
end
