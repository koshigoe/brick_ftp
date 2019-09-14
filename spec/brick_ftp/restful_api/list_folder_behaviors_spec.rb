# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListFolderBehaviors, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Behavior object' do
        expected_behavior = BrickFTP::Types::Behavior.new(
          id: 1,
          behavior: 'webhook',
          path: 'webhook',
          value: {
            'method' => 'GET',
          }
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/behaviors/folders/a?behavior=webhook&recursive=true')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_behavior.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::ListFolderBehaviors::Params.new(
          path: 'a',
          recursive: true,
          behavior: 'webhook'
        )
        command = BrickFTP::RESTfulAPI::ListFolderBehaviors.new(rest)

        expect(command.call(params)).to eq([expected_behavior])
      end
    end
  end
end
