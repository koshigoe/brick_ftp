# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListNotifications, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Notification object' do
        expected_notification = BrickFTP::Types::Notification.new(
          id: 1234,
          path: 'a/b/c',
          user_id: 1,
          username: 'user',
          send_interval: 'daily',
          unsubscribed: false
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/notifications.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_notification.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListNotifications.new(rest)

        expect(command.call).to eq([expected_notification])
      end
    end
  end
end
