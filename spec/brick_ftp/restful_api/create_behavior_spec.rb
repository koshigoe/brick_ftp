# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateBehavior, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Behavior object' do
        created_behavior = BrickFTP::Types::Behavior.new(
          id: 1,
          behavior: 'webhook',
          path: 'webhook',
          value: {
            'method' => 'GET',
          }
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/behaviors.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { path: 'a', behavior: 'webhook', value: %w[https://a.mywebhookhandler.com] }.to_json
          )
          .to_return(body: created_behavior.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateBehavior::Params.new(
          path: 'a',
          behavior: 'webhook',
          value: %w[https://a.mywebhookhandler.com]
        )
        command = BrickFTP::RESTfulAPI::CreateBehavior.new(rest)

        expect(command.call(params)).to eq created_behavior
      end
    end
  end
end
