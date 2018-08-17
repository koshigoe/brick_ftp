# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::Commands::CountUsers, type: :lib do
  describe '#call' do
    it 'return count' do
      stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/users.json?action=count')
        .with(
          basic_auth: %w[api-key x],
          headers: {
            'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
          }
        )
        .to_return(body: '{"data":{"count":1234}}')

      rest = BrickFTP::REST.new('subdomain', 'api-key')
      command = BrickFTP::Commands::CountUsers.new(rest)

      expect(command.call).to eq 1234
    end
  end
end
