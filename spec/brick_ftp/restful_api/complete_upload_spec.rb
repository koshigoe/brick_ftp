# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CompleteUpload, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'complete upload' do
        expected_file = BrickFTP::Types::File.new(
          id: 1_020_304_050,
          path: 'NewFile.txt',
          display_name: 'NewFile.txt',
          type: 'file',
          size: 412,
          mtime: '2014-05-17T05:14:35+00:00',
          provided_mtime: nil,
          crc32: nil,
          md5: nil,
          region: 'us-east-1',
          permissions: 'rwd'
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/files/a%20b%2Fc')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { ref: 'put-378670', action: 'end' }.to_json
          )
          .to_return(body: expected_file.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CompleteUpload::Params.new(
          ref: 'put-378670',
          path: 'a b/c'
        )
        command = BrickFTP::RESTfulAPI::CompleteUpload.new(rest)

        expect(command.call(params)).to eq expected_file
      end
    end
  end
end
