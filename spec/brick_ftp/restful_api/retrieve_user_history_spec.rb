# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::RetrieveUserHistory, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of History object' do
        expected_history = BrickFTP::Types::History.new(
          id: 903_767_970,
          when: '2015-10-27T15:09:55-04:00',
          user_id: 54_321,
          username: 'justice.london',
          action: 'create',
          path: 'accounts.xls',
          destination: 'accounts.xls',
          ip: '86.75.30.9',
          interface: 'ftp'
        )

        url = 'https://subdomain.brickftp.com/api/rest/v1/history/users/54321.json?page=1&per_page=1&start_at=2018-08-17T00:00:00Z'
        stub_request(:get, url)
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_history.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::RetrieveUserHistory.new(rest)

        res = command.call(54_321, page: 1, per_page: 1, start_at: Time.parse('2018-08-17T00:00:00Z'))
        expect(res).to eq([expected_history])
      end
    end

    context 'incorrect page' do
      it 'raise exception' do
        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::RetrieveUserHistory.new(rest)

        expect { command.call(54_321, page: 'a') }.to raise_error(ArgumentError, 'page must be greater than 0.')
      end
    end

    context 'incorrect per_page' do
      it 'raise exception' do
        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::RetrieveUserHistory.new(rest)

        expect { command.call(54_321, per_page: 'a') }
          .to raise_error(ArgumentError, 'per_page must be greater than 0 and less than equal 10000.')
      end
    end

    context 'incorrect start_at' do
      it 'raise exception' do
        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::RetrieveUserHistory.new(rest)

        expect { command.call(54_321, start_at: 'a') }.to raise_error(ArgumentError, 'start_at must be a Time.')
      end
    end
  end
end
