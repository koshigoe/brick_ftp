# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListFolderBehaviors, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Behavior object' do
        expected_behavior = BrickFTP::Types::Behavior.new(
          id: 38,
          path: 'Finance',
          behavior: 'webhook',
          value: %w[https://a.mywebhookhandler.com]
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/behaviors/folders/a?recursive=1')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_behavior.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListFolderBehaviors.new(rest)

        expect(command.call('a', recursive: true)).to eq([expected_behavior])
      end
    end
  end
end
