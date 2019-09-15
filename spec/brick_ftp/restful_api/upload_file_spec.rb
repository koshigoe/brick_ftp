# frozen_string_literal: true

require 'spec_helper'
require 'stringio'

RSpec.describe BrickFTP::RESTfulAPI::UploadFile, type: :lib do
  describe '#call' do
    context 'chunk_size: nil' do
      it 'single upload' do
        expected_upload = BrickFTP::Types::Upload.new(
          ref: 'put-378670',
          http_method: 'PUT',
          upload_uri: 'https://s3.amazonaws.com/objects.files.com/'
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/files/path')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { action: 'put' }.to_json
          )
          .to_return(body: expected_upload.to_h.to_json)

        stub_request(:put, 'https://s3.amazonaws.com/objects.files.com/')
          .with(body: 'TEST')
          .to_return(body: '', status: 200)

        expected_file = BrickFTP::Types::File.new(
          id: 1_020_304_050,
          path: 'path',
          display_name: 'path',
          type: 'file',
          size: 412,
          mtime: '2014-05-17T05:14:35+00:00',
          provided_mtime: nil,
          crc32: nil,
          md5: nil,
          region: 'us-east-1',
          permissions: 'rwd'
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/files/path')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { ref: 'put-378670', action: 'end' }.to_json
          )
          .to_return(body: expected_file.to_h.to_json)

        client = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::UploadFile.new(client)
        io = StringIO.new('TEST')

        expect(command.call(path: 'path', data: io)).to eq expected_file
      end
    end

    context 'chunk_size: 5_242_880' do
      context 'File' do
        it 'multi upload' do
          expected_upload = BrickFTP::Types::Upload.new(
            ref: 'put-378670',
            http_method: 'PUT',
            upload_uri: 'https://s3.amazonaws.com/objects.files.com/',
            part_number: 1
          )

          stub_request(:post, 'https://subdomain.files.com/api/rest/v1/files/path')
            .with(
              basic_auth: %w[api-key x],
              headers: {
                'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              },
              body: { action: 'put' }.to_json
            )
            .to_return(body: expected_upload.to_h.to_json)

          stub_request(:put, 'https://s3.amazonaws.com/objects.files.com/')
            .with(body: 'a' * 5_242_880)
            .to_return(body: '', status: 200)

          expected_upload2 = BrickFTP::Types::Upload.new(
            ref: 'put-378670',
            http_method: 'PUT',
            upload_uri: 'https://s3.amazonaws.com/objects.files.com/2',
            part_number: 2
          )

          stub_request(:post, 'https://subdomain.files.com/api/rest/v1/files/path')
            .with(
              basic_auth: %w[api-key x],
              headers: {
                'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              },
              body: { ref: 'put-378670', part: 2, action: 'put' }.to_json
            )
            .to_return(body: expected_upload2.to_h.to_json)

          stub_request(:put, 'https://s3.amazonaws.com/objects.files.com/2')
            .with(body: 'b')
            .to_return(body: '', status: 200)

          expected_file = BrickFTP::Types::File.new(
            id: 1_020_304_050,
            path: 'path',
            display_name: 'path',
            type: 'file',
            size: 412,
            mtime: '2014-05-17T05:14:35+00:00',
            provided_mtime: nil,
            crc32: nil,
            md5: nil,
            region: 'us-east-1',
            permissions: 'rwd'
          )

          stub_request(:post, 'https://subdomain.files.com/api/rest/v1/files/path')
            .with(
              basic_auth: %w[api-key x],
              headers: {
                'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              },
              body: { ref: 'put-378670', action: 'end' }.to_json
            )
            .to_return(body: expected_file.to_h.to_json)

          client = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
          command = BrickFTP::RESTfulAPI::UploadFile.new(client)

          Tempfile.create('base') do |io|
            io.write('a' * 5_242_880 + 'b')
            io.flush
            io.rewind
            expect(command.call(path: 'path', data: io, chunk_size: 5_242_880)).to eq expected_file
          end
        end
      end

      context 'StringIO' do
        it 'single upload' do
          expected_upload = BrickFTP::Types::Upload.new(
            ref: 'put-378670',
            http_method: 'PUT',
            upload_uri: 'https://s3.amazonaws.com/objects.files.com/',
            part_number: 1
          )

          stub_request(:post, 'https://subdomain.files.com/api/rest/v1/files/path')
            .with(
              basic_auth: %w[api-key x],
              headers: {
                'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              },
              body: { action: 'put' }.to_json
            )
            .to_return(body: expected_upload.to_h.to_json)

          stub_request(:put, 'https://s3.amazonaws.com/objects.files.com/')
            .with(body: 'a' * 5_242_880 + 'b')
            .to_return(body: '', status: 200)

          expected_file = BrickFTP::Types::File.new(
            id: 1_020_304_050,
            path: 'path',
            display_name: 'path',
            type: 'file',
            size: 412,
            mtime: '2014-05-17T05:14:35+00:00',
            provided_mtime: nil,
            crc32: nil,
            md5: nil,
            region: 'us-east-1',
            permissions: 'rwd'
          )

          stub_request(:post, 'https://subdomain.files.com/api/rest/v1/files/path')
            .with(
              basic_auth: %w[api-key x],
              headers: {
                'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              },
              body: { ref: 'put-378670', action: 'end' }.to_json
            )
            .to_return(body: expected_file.to_h.to_json)

          client = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
          command = BrickFTP::RESTfulAPI::UploadFile.new(client)

          io = StringIO.new('a' * 5_242_880 + 'b')
          io.rewind
          expect(command.call(path: 'path', data: io, chunk_size: 5_242_880)).to eq expected_file
        end
      end
    end
  end
end
