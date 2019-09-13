# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListNotifications, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Notification object' do
        expected_notification = BrickFTP::Types::Notification.new(
          id: 1,
          group_id: 1,
          group_name: '',
          notify_user_actions: true,
          notify_on_copy: true,
          path: 'path',
          send_interval: 'fifteen_minutes',
          unsubscribed: true,
          unsubscribed_reason: '',
          user_id: 1,
          username: 'User'
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
