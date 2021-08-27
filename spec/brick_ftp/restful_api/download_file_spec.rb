# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::DownloadFile, type: :lib do
  describe '#call' do
    context 'correct request without action' do
      it 'return File object' do
        expected_file = BrickFTP::Types::File.new(
          id: 4_233_161_221,
          path: 'a b/c',
          display_name: 'John Smith.docx',
          type: 'file',
          size: 61_440,
          mtime: '2014-05-15T18:34:51+00:00',
          provided_mtime: '2014-05-15T18:34:51+00:00',
          crc32: 'f341cc60',
          md5: 'b67236f5bcd29d1307d574fb9fe585b5',
          region: 'us-east-1',
          permissions: 'rwd',
          download_uri: 'https://s3.amazonaws.com/objects.files.com/...'
        )

        url = 'https://subdomain.files.com/api/rest/v1/files/a%20b%2Fc'
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

        expect(command.call('a b/c')).to eq(expected_file)
      end
    end

    context 'correct request with action' do
      it 'return File object' do
        expected_file = BrickFTP::Types::File.new(
          id: 4_233_161_221,
          path: 'a b/c',
          display_name: 'John Smith.docx',
          type: 'file',
          size: 61_440,
          mtime: '2014-05-15T18:34:51+00:00',
          provided_mtime: '2014-05-15T18:34:51+00:00',
          crc32: 'f341cc60',
          md5: 'b67236f5bcd29d1307d574fb9fe585b5',
          region: 'us-east-1',
          permissions: 'rwd'
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

        expect(command.call('a b/c', stat: true)).to eq(expected_file)
      end
    end
  end
end
