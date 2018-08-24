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

        url = 'https://subdomain.brickftp.com/api/rest/v1/folders/a%20b%2Fc?page=1&per_page=2&search=a%20b%2Fc&sort_by[path]=desc&sort_by[size]=desc&sort_by[modified_at_datetime]=desc'
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

    context 'invalid parameters' do
      context 'page' do
        it 'raise ArgumentError' do
          rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
          command = BrickFTP::RESTfulAPI::ListFolders.new(rest)

          expect { command.call('a b/c', page: -1) }.to raise_error(ArgumentError, 'page must be greater than 0.')
        end
      end

      context 'per_page' do
        it 'raise ArgumentError' do
          rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
          command = BrickFTP::RESTfulAPI::ListFolders.new(rest)

          expect { command.call('a b/c', per_page: -1) }
            .to raise_error(ArgumentError, 'per_page must be greater than 0 and less than equal 5000.')
        end
      end

      context 'sort_by' do
        it 'raise ArgumentError' do
          rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
          command = BrickFTP::RESTfulAPI::ListFolders.new(rest)

          expect { command.call('a b/c', 'sort_by[path]': 'value') }
            .to raise_error(ArgumentError, 'sort_by[*] must be `asc` or `desc`.')
        end
      end
    end
  end
end
