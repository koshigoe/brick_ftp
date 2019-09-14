# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateSsoStrategy, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created SsoStrategy object' do
        created_sso_strategy = BrickFTP::Types::SsoStrategy.new(
          provider: 'okta',
          id: 1,
          subdomain: 'my-site',
          provision_users: true,
          provision_groups: true,
          provision_group_default: 'Employees',
          provision_group_exclusion: 'Employees',
          provision_group_inclusion: 'Employees',
          provision_group_required: '',
          provision_attachments_permission: true,
          provision_dav_permission: true,
          provision_ftp_permission: true,
          provision_sftp_permission: true,
          provision_time_zone: 'Eastern Time (US & Canada)'
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/sso_strategies.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              provider: 'okta',
              subdomain: 'subdomain',
              client_id: '[client id]',
              client_secret: '[client secret]',
              provision_users: true,
              provision_groups: true,
              provision_group_default: 'Employees',
              provision_group_exclusion: 'Employees',
              provision_group_inclusion: 'Employees',
              provision_attachments_permission: true,
              provision_dav_permission: true,
              provision_ftp_permission: true,
              provision_sftp_permission: true,
              provision_time_zone: 'Eastern Time (US & Canada)',
            }.to_json
          )
          .to_return(body: created_sso_strategy.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateSsoStrategy::Params.new(
          provider: 'okta',
          subdomain: 'subdomain',
          client_id: '[client id]',
          client_secret: '[client secret]',
          provision_users: true,
          provision_groups: true,
          provision_group_default: 'Employees',
          provision_group_exclusion: 'Employees',
          provision_group_inclusion: 'Employees',
          provision_attachments_permission: true,
          provision_dav_permission: true,
          provision_ftp_permission: true,
          provision_sftp_permission: true,
          provision_time_zone: 'Eastern Time (US & Canada)'
        )
        command = BrickFTP::RESTfulAPI::CreateSsoStrategy.new(rest)

        expect(command.call(params)).to eq created_sso_strategy
      end
    end
  end
end
