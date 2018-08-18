# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetBehavior, type: :lib do
  describe '#call' do
    context 'given correct Behavior ID' do
      it 'return Behavior object' do
        expected_behavior = BrickFTP::Types::Behavior.new(
          id:  38,
          path: 'Finance',
          behavior: 'webhook',
          value: %w[https://a.mywebhookhandler.com]
        )

        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/behaviors/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: expected_behavior.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetBehavior.new(rest)

        expect(command.call(1234)).to eq expected_behavior
      end
    end

    context 'Behavior not found' do
      it 'return nil' do
        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/behaviors/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '[]')

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetBehavior.new(rest)

        expect(command.call(1234)).to be_nil
      end
    end
  end
end
