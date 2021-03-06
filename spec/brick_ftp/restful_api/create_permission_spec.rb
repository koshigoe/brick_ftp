# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreatePermission, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Permission object' do
        created_permission = BrickFTP::Types::Permission.new(
          id: 1234,
          user_id: 1,
          path: 'a/b/c',
          permission: 'writeonly'
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/permissions.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { user_id: 1, path: 'a/b/c', permission: 'writeonly' }.to_json
          )
          .to_return(body: created_permission.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreatePermission::Params.new(user_id: 1, path: 'a/b/c', permission: 'writeonly')
        command = BrickFTP::RESTfulAPI::CreatePermission.new(rest)

        expect(command.call(params)).to eq created_permission
      end
    end
  end
end
