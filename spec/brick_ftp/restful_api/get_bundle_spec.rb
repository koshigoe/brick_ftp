# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetBundle, type: :lib do
  describe '#call' do
    context 'given correct Bundle ID' do
      it 'return Bundle object' do
        expected_bundle = BrickFTP::Types::Bundle.new(
          id: 212_228,
          code: '4d3d3d3d3',
          url: 'https://site.files.com/f/4d3d3d3d3',
          user_id: 12_345,
          created_at: '2015-10-14T12:52:25-04:00',
          paths:  %w[accounts.xls]
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/bundles/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: expected_bundle.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetBundle.new(rest)

        expect(command.call(1234)).to eq expected_bundle
      end
    end

    context 'Bundle not found' do
      it 'return nil' do
        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/bundles/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '[]')

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetBundle.new(rest)

        expect(command.call(1234)).to be_nil
      end
    end
  end
end
