# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::UpdateBehavior, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return updated Behavior object' do
        updated_behavior = BrickFTP::Types::Behavior.new(
          id:  38,
          path: 'a',
          behavior: 'webhook',
          value: %w[https://a.mywebhookhandler.com]
        )

        stub_request(:patch, 'https://subdomain.brickftp.com/api/rest/v1/behaviors/38.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { value: %w[https://a.mywebhookhandler.com] }.to_json
          )
          .to_return(body: updated_behavior.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::UpdateBehavior::Params.new(value: %w[https://a.mywebhookhandler.com])
        command = BrickFTP::RESTfulAPI::UpdateBehavior.new(rest)

        expect(command.call(38, params)).to eq updated_behavior
      end
    end
  end
end
