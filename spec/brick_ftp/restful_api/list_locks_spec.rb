# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListLocks, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Lock object' do
        expected_lock = BrickFTP::Types::Lock.new(
          timeout: 43_200,
          depth: 'infinity',
          owner: 'user',
          path: 'locked_file',
          scope: 'shared',
          token: '17c54824e9931a4688ca032d03f6663c',
          type: 'write',
          user_id: 1,
          username: 'username'
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/locks/phun%2Fphysics1.png')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_lock.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListLocks.new(rest)

        expect(command.call('phun/physics1.png')).to eq([expected_lock])
      end
    end
  end
end
