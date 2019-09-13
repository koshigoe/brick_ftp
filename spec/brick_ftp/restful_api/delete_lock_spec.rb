# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::DeleteLock, type: :lib do
  describe '#call' do
    it 'return true' do
      stub_request(:delete, 'https://subdomain.files.com/api/rest/v1/locks/phun%2Fphysics1.png')
        .with(
          basic_auth: %w[api-key x],
          headers: {
            'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
          },
          body: { token: 'token' }.to_json
        )
        .to_return(body: nil, status: 204)

      rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
      command = BrickFTP::RESTfulAPI::DeleteLock.new(rest)

      expect(command.call(path: 'phun/physics1.png', token: 'token')).to be_truthy
    end
  end
end
