# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetFolderSize, type: :lib do
  describe '#call' do
    it 'return size' do
      stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/folders/path?action=size')
        .with(
          basic_auth: %w[api-key x],
          headers: {
            'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
          }
        )
        .to_return(body: '{"data":{"size":1234}}')

      client = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
      command = BrickFTP::RESTfulAPI::GetFolderSize.new(client)

      expect(command.call('path')).to eq 1234
    end
  end
end
