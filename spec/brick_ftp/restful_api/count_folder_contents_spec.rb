# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CountFolderContents, type: :lib do
  describe '#call' do
    context 'recursive: true' do
      it 'return count' do
        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/folders/path?action=count')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: { data: { count: 3 } }.to_json)

        client = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::CountFolderContents.new(client)

        expected_count = BrickFTP::Types::FolderContentsCount.new(total: 3)
        expect(command.call('path', recursive: true)).to eq expected_count
      end
    end

    context 'recursive: false' do
      it 'return count' do
        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/folders/path?action=count_nrs')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: { data: { count: { files: 1, folders: 2 } } }.to_json)

        client = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::CountFolderContents.new(client)

        expected_count = BrickFTP::Types::FolderContentsCount.new(files: 1, folders: 2)
        expect(command.call('path')).to eq expected_count
      end
    end
  end
end
