# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetAutomation, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Automation object' do
        expected_automation = BrickFTP::Types::Automation.new(
          id: 1,
          automation: 'create_folder',
          source: '',
          destination: '',
          destination_replace_from: '',
          destination_replace_to: '',
          interval: 'week',
          next_process_on: '2020-01-01',
          path: '',
          realtime: true,
          user_id: 1,
          user_ids: [],
          group_ids: []
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/automations/1.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: expected_automation.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetAutomation.new(rest)

        expect(command.call(id: 1)).to eq(expected_automation)
      end
    end

    context 'API key not found' do
      it 'raise exception' do
        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/automations/1.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '[]', status: 404)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetAutomation.new(rest)

        expect { command.call(id: 1) }.to raise_error(BrickFTP::RESTfulAPI::Client::Error)
      end
    end
  end
end
