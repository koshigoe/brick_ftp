# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListSsoStrategies, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of SsoStrategy object' do
        expected_sso_strategy = BrickFTP::Types::SsoStrategy.new(
          id: 1,
          admin_ids: [],
          name: 'owners',
          notes: '',
          user_ids: [],
          usernames: []
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/sso_strategies.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_sso_strategy.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListSsoStrategies.new(rest)

        expect(command.call).to eq([expected_sso_strategy])
      end
    end
  end
end
