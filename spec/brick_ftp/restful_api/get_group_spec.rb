# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetGroup, type: :lib do
  describe '#call' do
    context 'given correct Group ID' do
      it 'return Group object' do
        expected_group = BrickFTP::Types::Group.new(
          id: 1,
          admin_ids: [],
          name: 'owners',
          notes: '',
          user_ids: [],
          usernames: []
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/groups/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: expected_group.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetGroup.new(rest)

        expect(command.call(1234)).to eq expected_group
      end
    end

    context 'Group not found' do
      it 'return nil' do
        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/groups/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '[]')

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetGroup.new(rest)

        expect(command.call(1234)).to be_nil
      end
    end
  end
end
