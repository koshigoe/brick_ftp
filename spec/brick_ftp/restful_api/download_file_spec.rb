# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::DownloadFile, type: :lib do
  describe '#call' do
    it 'return File object' do
      expected_file = BrickFTP::Types::File.new(
        id: 1,
        path: 'path/file.txt',
        display_name: 'file.txt',
        type: 'file',
        size: 1024,
        mtime: '2000-01-01 01:00:00 UTC',
        provided_mtime: '2000-01-01 01:00:00 UTC',
        crc32: '70976923',
        md5: '17c54824e9931a4688ca032d03f6663c',
        region: 'us-east-1',
        permissions: 'rpw',
        subfolders_locked?: true,
        download_uri: 'https://mysite.files.com/...',
        priority_color: 'red',
        preview_id: 1,
        preview: ''
      )

      url = 'https://subdomain.files.com/api/rest/v1/files/a%20b%2Fc?action=stat'
      stub_request(:get, url)
        .with(
          basic_auth: %w[api-key x],
          headers: {
            'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
          }
        )
        .to_return(body: expected_file.to_h.to_json)

      rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
      command = BrickFTP::RESTfulAPI::DownloadFile.new(rest)

      expect(command.call('a b/c', action: 'stat')).to eq(expected_file)
    end
  end
end
