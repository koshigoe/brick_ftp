# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListBundleContents, type: :lib do
  describe '#call' do
    context 'correct request' do
      context 'with path' do
        it 'return Array of BundleContent object' do
          expected_bundle_content = BrickFTP::Types::BundleContent.new(
            path: 'cloud',
            type: 'directory',
            size: nil
          )

          stub_request(:post, 'https://subdomain.files.com/api/rest/v1/bundles/contents/a%20b')
            .with(
              basic_auth: %w[api-key x],
              headers: {
                'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              },
              body: { code: 'a', password: 'p' }.to_json
            )
            .to_return(body: [expected_bundle_content.to_h].to_json)

          rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
          command = BrickFTP::RESTfulAPI::ListBundleContents.new(rest)
          params = BrickFTP::RESTfulAPI::ListBundleContents::Params.new(code: 'a', password: 'p')

          expect(command.call(params, path: 'a b')).to eq([expected_bundle_content])
        end
      end

      context 'without path' do
        it 'return Array of BundleContent object' do
          expected_bundle_content = BrickFTP::Types::BundleContent.new(
            path: 'cloud',
            type: 'directory',
            size: nil
          )

          stub_request(:post, 'https://subdomain.files.com/api/rest/v1/bundles/contents.json')
            .with(
              basic_auth: %w[api-key x],
              headers: {
                'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              },
              body: { code: 'a', password: 'p' }.to_json
            )
            .to_return(body: [expected_bundle_content.to_h].to_json)

          rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
          command = BrickFTP::RESTfulAPI::ListBundleContents.new(rest)
          params = BrickFTP::RESTfulAPI::ListBundleContents::Params.new(code: 'a', password: 'p')

          expect(command.call(params)).to eq([expected_bundle_content])
        end
      end
    end
  end
end
