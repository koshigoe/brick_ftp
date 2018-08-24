# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::RetrieveSiteHistory, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of History object' do
        expected_history = BrickFTP::Types::History.new(
          id: 869_831_023,
          when: '2015-09-19T22:30:20-04:00',
          user_id: 12_345,
          username: 'fred.admin',
          action: 'login',
          ip: '172.19.113.171',
          interface: 'ftp'
        )

        url = 'https://subdomain.brickftp.com/api/rest/v1/history.json?page=1&per_page=1&start_at=2018-08-17T00:00:00Z'
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

    context 'incorrect page' do
      it 'raise exception' do
        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::RetrieveSiteHistory.new(rest)

        expect { command.call(page: 'a') }.to raise_error(ArgumentError, 'page must be greater than 0.')
      end
    end

    context 'incorrect per_page' do
      it 'raise exception' do
        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::RetrieveSiteHistory.new(rest)

        expect { command.call(per_page: 'a') }
          .to raise_error(ArgumentError, 'per_page must be greater than 0 and less than equal 10000.')
      end
    end

    context 'incorrect start_at' do
      it 'raise exception' do
        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::RetrieveSiteHistory.new(rest)

        expect { command.call(start_at: 'a') }.to raise_error(ArgumentError, 'start_at must be a Time.')
      end
    end
  end
end
