# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::UpdateAutomation, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return updated Automation object' do
        updated_automation = BrickFTP::Types::Automation.new(
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

        stub_request(:put, 'https://subdomain.files.com/api/rest/v1/automations/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              source: 'source',
              destination: 'destination',
              interval: 'year',
            }.to_json
          )
          .to_return(body: updated_automation.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::UpdateAutomation::Params.new(
          source: 'source',
          destination: 'destination',
          interval: 'year'
        )
        command = BrickFTP::RESTfulAPI::UpdateAutomation.new(rest)

        expect(command.call(1234, params)).to eq updated_automation
      end
    end
  end
end
