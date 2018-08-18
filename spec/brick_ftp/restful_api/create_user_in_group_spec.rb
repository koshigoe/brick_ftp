# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateUserInGroup, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created User object' do
        created_user = BrickFTP::Types::User.new(
          id: 1234,
          username: 'user',
          authentication_method: 'password',
          last_login_at: nil,
          authenticate_until: nil,
          name: nil,
          email: 'user@example.com',
          notes: nil,
          group_ids: '1',
          ftp_permission: true,
          sftp_permission: true,
          dav_permission: true,
          restapi_permission: true,
          attachments_permission: true,
          self_managed: true,
          require_password_change: false,
          require_2fa: false,
          allowed_ips: nil,
          user_root: '',
          time_zone: 'Eastern Time (US & Canada)',
          language: '',
          ssl_required: 'use_system_setting',
          site_admin: true,
          password_set_at: nil,
          receive_admin_alerts: true,
          subscribe_to_newsletter: false,
          last_protocol_cipher: nil,
          lockout_expires: nil,
          admin_group_ids: []
        )

        stub_request(:post, 'https://subdomain.brickftp.com/api/rest/v1/groups/1/users.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { user: { username: 'user' } }.to_json
          )
          .to_return(body: created_user.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateUserInGroup::Params.new(username: 'user')
        command = BrickFTP::RESTfulAPI::CreateUserInGroup.new(rest)

        expect(command.call(1, params)).to eq created_user
      end
    end
  end
end
