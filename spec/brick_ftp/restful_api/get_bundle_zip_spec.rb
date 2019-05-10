# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetBundleZip, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return FileInBundle object' do
        expected_bundle_zip = BrickFTP::Types::BundleZip.new(
          download_uri: 'https://s3.amazonaws.com/objects.files.com/metadata/10099/2e2376c0-7527-0133-21fb-0a2d4abb99a7?..'
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/bundles/zip.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { code: 'a', password: 'p' }.to_json
          )
          .to_return(body: expected_bundle_zip.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetBundleZip.new(rest)
        params = BrickFTP::RESTfulAPI::GetBundleZip::Params.new(code: 'a', password: 'p')

        expect(command.call(params)).to eq(expected_bundle_zip)
      end
    end
  end
end
