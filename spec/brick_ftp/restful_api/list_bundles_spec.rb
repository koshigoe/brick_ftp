# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListBundles, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Bundle object' do
        expected_bundle = BrickFTP::Types::Bundle.new(
          id: 212_228,
          code: '4d3d3d3d3',
          url: 'https://site.brickftp.com/f/4d3d3d3d3',
          user_id: 12_345,
          created_at: '2015-10-14T12:52:25-04:00',
          paths:  %w[accounts.xls]
        )

        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/bundles.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_bundle.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListBundles.new(rest)

        expect(command.call).to eq([expected_bundle])
      end
    end
  end
end
