# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListBehaviors, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Behavior object' do
        expected_behavior = BrickFTP::Types::Behavior.new(
          id: 1,
          behavior: 'webhook',
          path: '',
          value: {
            'method' => 'GET',
          }
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/behaviors.json?behavior=webhook')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_behavior.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::ListBehaviors::Params.new(behavior: 'webhook')
        command = BrickFTP::RESTfulAPI::ListBehaviors.new(rest)

        expect(command.call(params)).to eq([expected_behavior])
      end
    end
  end
end
