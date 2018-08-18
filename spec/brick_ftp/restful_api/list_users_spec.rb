# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListUsers, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of User object' do
        expected_user = BrickFTP::Types::User.new(
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

        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/users.json?page=1&per_page=1000')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_user.to_h].to_json)

        rest = BrickFTP::REST.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListUsers.new(rest)
        users = command.call

        expect(users).to eq([expected_user])
      end
    end

    context 'incorrect page' do
      it 'raise exception' do
        rest = BrickFTP::REST.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListUsers.new(rest)

        expect { command.call(page: 'a') }.to raise_error(ArgumentError, 'page must be greater than 0.')
      end
    end

    context 'incorrect per_page' do
      it 'raise exception' do
        rest = BrickFTP::REST.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListUsers.new(rest)

        expect { command.call(per_page: 'a') }.to raise_error(ArgumentError, 'per_page must be greater than 0.')
      end
    end
  end
end
