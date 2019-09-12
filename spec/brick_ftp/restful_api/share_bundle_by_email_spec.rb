# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ShareBundleByEmail, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return empty body' do
        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/bundles/1234/share.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              to: %w[johndoe@gmail.com],
              note: 'Just a note.',
            }.to_json
          )
          .to_return(body: nil, status: 204)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::ShareBundleByEmail::Params.new(
          to: %w[johndoe@gmail.com],
          note: 'Just a note.'
        )
        command = BrickFTP::RESTfulAPI::ShareBundleByEmail.new(rest)

        expect(command.call(1234, params)).to be_truthy
      end
    end
  end
end
