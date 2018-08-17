# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::Commands::UpdateUser, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return updated User object' do
        updated_user = BrickFTP::Types::User.new(
          'id': 1234,
          'username': 'user',
          'authentication_method': 'password',
          'last_login_at': nil,
          'authenticate_until': nil,
          'name': nil,
          'email': 'user@example.com',
          'notes': nil,
          'group_ids': '',
          'ftp_permission': true,
          'sftp_permission': true,
          'dav_permission': true,
          'restapi_permission': true,
          'attachments_permission': true,
          'self_managed': true,
          'require_password_change': false,
          'require_2fa': false,
          'allowed_ips': nil,
          'user_root': '',
          'time_zone': 'Eastern Time (US & Canada)',
          'language': '',
          'ssl_required': 'use_system_setting',
          'site_admin': true,
          'password_set_at': nil,
          'receive_admin_alerts': true,
          'subscribe_to_newsletter': false,
          'last_protocol_cipher': nil,
          'lockout_expires': nil,
          'admin_group_ids': []
        )

        stub_request(:put, 'https://subdomain.brickftp.com/api/rest/v1/users/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { username: 'user' }.to_json
          )
          .to_return(body: updated_user.to_h.to_json)

        rest = BrickFTP::REST.new('subdomain', 'api-key')
        params = BrickFTP::Commands::UpdateUser::Params.new(username: 'user')
        command = BrickFTP::Commands::UpdateUser.new(rest)
        user = command.call(1234, params)

        expect(user).to eq updated_user
      end
    end
  end
end
