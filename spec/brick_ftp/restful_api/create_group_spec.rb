# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateGroup, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Group object' do
        created_group = BrickFTP::Types::Group.new(
          id: 1234,
          name: 'group',
          notes: 'notes',
          user_ids: '1,2,3',
          usernames: 'a,b,c',
          admin_ids: [1, 2, 3]
        )

        stub_request(:post, 'https://subdomain.brickftp.com/api/rest/v1/groups.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { name: 'group' }.to_json
          )
          .to_return(body: created_group.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateGroup::Params.new(name: 'group')
        command = BrickFTP::RESTfulAPI::CreateGroup.new(rest)

        expect(command.call(params)).to eq created_group
      end
    end
  end
end
