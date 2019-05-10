# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateBundle, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Bundle object' do
        created_bundle = BrickFTP::Types::Bundle.new(
          id: 212_228,
          code: '4d3d3d3d3',
          url: 'https://site.files.com/f/4d3d3d3d3',
          user_id: 12_345,
          created_at: '2015-10-14T12:52:25-04:00',
          paths:  %w[accounts.xls]
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/bundles.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { paths: %w[accounts.xls], password: 'pass' }.to_json
          )
          .to_return(body: created_bundle.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateBundle::Params.new(paths: %w[accounts.xls], password: 'pass')
        command = BrickFTP::RESTfulAPI::CreateBundle.new(rest)

        expect(command.call(params)).to eq created_bundle
      end
    end
  end
end
