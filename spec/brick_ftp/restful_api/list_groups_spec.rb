# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListGroups, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Group object' do
        expected_group = BrickFTP::Types::Group.new(
          id: 1234,
          name: 'test',
          notes: 'notes',
          user_ids: '',
          usernames: nil,
          admin_ids: []
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/groups.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_group.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListGroups.new(rest)

        expect(command.call).to eq([expected_group])
      end
    end
  end
end
