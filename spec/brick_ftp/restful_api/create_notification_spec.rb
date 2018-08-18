# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateNotification, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Notification object' do
        created_notification = BrickFTP::Types::Notification.new(
          id: 1234,
          path: 'a/b/c',
          user_id: '1',
          username: 'user',
          send_interval: 'daily',
          unsubscribed: false
        )

        stub_request(:post, 'https://subdomain.brickftp.com/api/rest/v1/notifications.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { path: 'a/b/c', user_id: 1 }.to_json
          )
          .to_return(body: created_notification.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateNotification::Params.new(path: 'a/b/c', user_id: 1)
        command = BrickFTP::RESTfulAPI::CreateNotification.new(rest)

        expect(command.call(params)).to eq created_notification
      end
    end
  end
end
