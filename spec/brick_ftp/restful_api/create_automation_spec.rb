# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateAutomation, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Automation object' do
        created_automation = BrickFTP::Types::Automation.new(
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

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/automations.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              automation: 'create_folder',
              source: 'source',
              destination: 'destination',
              interval: 'year',
            }.to_json
          )
          .to_return(body: created_automation.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateAutomation::Params.new(
          automation: 'create_folder',
          source: 'source',
          destination: 'destination',
          interval: 'year'
        )
        command = BrickFTP::RESTfulAPI::CreateAutomation.new(rest)

        expect(command.call(params)).to eq created_automation
      end
    end
  end
end
