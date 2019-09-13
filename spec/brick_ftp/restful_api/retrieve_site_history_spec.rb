# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::RetrieveSiteHistory, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of History object' do
        expected_history = BrickFTP::Types::History.new(
          id: 1,
          when: '2000-01-01 01:00:00 UTC',
          destination: '/to_path',
          display: 'full',
          ip: '192.283.128.182',
          path: 'path',
          source: '/from_path',
          targets: [],
          user_id: 1,
          username: 'user',
          action: 'create',
          failure_type: 'none',
          interface: 'web'
        )

        url = 'https://subdomain.files.com/api/rest/v1/history.json?page=1&per_page=1&start_at=2018-08-17T00:00:00Z'
        stub_request(:get, url)
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_history.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::RetrieveSiteHistory.new(rest)

        res = command.call(page: 1, per_page: 1, start_at: Time.parse('2018-08-17T00:00:00Z'))
        expect(res).to eq([expected_history])
      end
    end
  end
end
