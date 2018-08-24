# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::DeleteFolder, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'delete folder' do
        stub_request(:delete, 'https://subdomain.brickftp.com/api/rest/v1/files/a%20b%2Fc')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Depth' => 'infinity',
            }
          )
          .to_return(body: '[]')

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::DeleteFolder.new(rest)

        expect(command.call('a b/c', recursive: true)).to be_truthy
      end
    end
  end
end
