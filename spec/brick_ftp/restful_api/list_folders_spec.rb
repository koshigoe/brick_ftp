# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListFolders, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Folder object' do
        expected_folder = BrickFTP::Types::File.new(
          id:  867_530_900,
          path:  'a b/c',
          display_name:  'Needs Review',
          type:  'directory',
          size:  nil,
          mtime:  '2014-05-15T20:26:18+00:00',
          provided_mtime:  '2014-05-15T20:26:26+00:00',
          crc32:  nil,
          md5:  nil,
          permissions:  'rwd',
          subfolders_locked?:  nil
        )

        query = 'page=1&per_page=2&search=a%20b%2Fc&sort_by[path]=desc&sort_by[size]=desc&sort_by[modified_at_datetime]=desc'
        url = "https://subdomain.brickftp.com/api/rest/v1/folders/a%20b%2Fc?#{query}"
        stub_request(:get, url)
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_folder.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListFolders.new(rest)
        params = BrickFTP::RESTfulAPI::ListFolders::Params.new(
          page: 1,
          per_page: 2,
          search: 'a b/c',
          'sort_by[path]': 'desc',
          'sort_by[size]': 'desc',
          'sort_by[modified_at_datetime]': 'desc'
        )

        expect(command.call('a b/c', params)).to eq([expected_folder])
      end
    end
  end
end
