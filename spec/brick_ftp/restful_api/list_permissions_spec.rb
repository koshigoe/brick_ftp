# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListPermissions, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Permission object' do
        expected_permission = BrickFTP::Types::Permission.new(
          id: 1234,
          user_id: 1234,
          username: 'user',
          group_id: 1234,
          group_name: 'group',
          path: 'path',
          permission: 'full',
          recursive: true
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/permissions.json?path=path')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_permission.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListPermissions.new(rest)

        expect(command.call(path: 'path')).to eq([expected_permission])
      end
    end
  end
end
