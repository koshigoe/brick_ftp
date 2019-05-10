# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::AddGroupMember, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Group Membership object' do
        created_group_membership = BrickFTP::Types::GroupMembership.new(
          id: 1234,
          group_id: 1,
          user_id: 2,
          admin: true
        )

        stub_request(:put, 'https://subdomain.files.com/api/rest/v1/groups/1/memberships/2.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { membership: { admin: true } }.to_json
          )
          .to_return(body: created_group_membership.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::AddGroupMember::Params.new(admin: true)
        command = BrickFTP::RESTfulAPI::AddGroupMember.new(rest)

        expect(command.call(1, 2, params)).to eq created_group_membership
      end
    end
  end
end
