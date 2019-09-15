# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::UpdateCurrentUser, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return updated User object' do
        updated_user = BrickFTP::Types::User.new(
          id: 1,
          admin_group_ids: [],
          allowed_ips: '127.0.0.1',
          attachments_permission: true,
          authenticate_until: '2000-01-01 01:00:00 UTC',
          authentication_method: 'password',
          bypass_site_allowed_ips: true,
          dav_permission: true,
          email: 'john.doe@files.com',
          ftp_permission: true,
          group_ids: [],
          language: 'en',
          last_login_at: '2000-01-01 01:00:00 UTC',
          last_protocol_cipher: '',
          lockout_expires: '2000-01-01 01:00:00 UTC',
          name: 'John Doe',
          notes: 'Internal notes on this user.',
          password_set_at: '2000-01-01 01:00:00 UTC',
          password_validity_days: 1,
          public_keys_count: 1,
          receive_admin_alerts: true,
          require_2fa: true,
          require_password_change: true,
          restapi_permission: true,
          self_managed: true,
          sftp_permission: true,
          site_admin: true,
          ssl_required: 'always_require',
          sso_strategy_id: 1,
          subscribe_to_newsletter: true,
          externally_managed: true,
          time_zone: 'Pacific Time (US & Canada)',
          user_root: '',
          username: 'user'
        )

        stub_request(:patch, 'https://subdomain.files.com/api/rest/v1/user.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              change_password: 'password',
              change_password_confirmation: 'password',
              email: 'johndoe@gmail.com',
              time_zone: 'Pacific Time (US & Canada)',
              language: 'en',
              skip_welcome_screen: true,
              announcements_read: true,
            }.to_json
          )
          .to_return(body: updated_user.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::UpdateCurrentUser::Params.new(
          change_password: 'password',
          change_password_confirmation: 'password',
          email: 'johndoe@gmail.com',
          time_zone: 'Pacific Time (US & Canada)',
          language: 'en',
          skip_welcome_screen: true,
          announcements_read: true
        )
        command = BrickFTP::RESTfulAPI::UpdateCurrentUser.new(rest)

        expect(command.call(params)).to eq updated_user
      end
    end
  end
end