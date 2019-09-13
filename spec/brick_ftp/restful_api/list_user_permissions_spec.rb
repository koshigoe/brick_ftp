# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListUserPermissions, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Permission object' do
        expected_permission = BrickFTP::Types::Permission.new(
          id: 1,
          user_id: 1,
          username: 'Sser',
          group_id: 1,
          group_name: '',
          path: '',
          permission: 'full',
          recursive: true
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/users/1/permissions.json?include_groups=true')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_permission.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListUserPermissions.new(rest)

        expect(command.call(id: 1, include_groups: true)).to eq([expected_permission])
      end
    end
  end
end
