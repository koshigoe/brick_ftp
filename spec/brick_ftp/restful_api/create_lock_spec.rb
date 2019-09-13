# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateLock, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Lock object' do
        created_lock = BrickFTP::Types::Lock.new(
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

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/locks/phun%2Fphysics1.png')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { timeout: 1 }.to_json
          )
          .to_return(body: created_lock.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateLock::Params.new(path: 'phun/physics1.png', timeout: 1)
        command = BrickFTP::RESTfulAPI::CreateLock.new(rest)

        expect(command.call(params)).to eq created_lock
      end
    end
  end
end
