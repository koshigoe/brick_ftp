# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateNotification, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Notification object' do
        created_notification = BrickFTP::Types::Notification.new(
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

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/notifications.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              group_id: 1,
              notify_on_copy: true,
              notify_user_actions: true,
              path: 'path',
              send_interval: 'daily',
              user_id: 1,
              username: 'User',
            }.to_json
          )
          .to_return(body: created_notification.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateNotification::Params.new(
          group_id: 1,
          notify_on_copy: true,
          notify_user_actions: true,
          path: 'path',
          send_interval: 'daily',
          user_id: 1,
          username: 'User'
        )
        command = BrickFTP::RESTfulAPI::CreateNotification.new(rest)

        expect(command.call(params)).to eq created_notification
      end
    end
  end
end
