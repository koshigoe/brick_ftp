# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ContinueUpload, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'continue upload' do
        expected_upload = BrickFTP::Types::Upload.new(
          ref: 'put-378670',
          path: 'NewFile.txt',
          action: 'put/write',
          ask_about_overwrites: false,
          http_method: 'PUT',
          upload_uri: 'https://s3.amazonaws.com/objects.files.com/..',
          partsize: 5_242_880,
          part_number: 2,
          available_parts: 10_000,
          send: {
            'partsize' => 'required-parameter Content-Length',
            'partdata' => 'body',
          },
          headers: {},
          parameters: {}
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/files/a%20b%2Fc')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { ref: 'put-378670', part: 2, action: 'put' }.to_json
          )
          .to_return(body: expected_upload.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::ContinueUpload::Params.new(ref: 'put-378670', part: 2)
        command = BrickFTP::RESTfulAPI::ContinueUpload.new(rest)

        expect(command.call('a b/c', params)).to eq expected_upload
      end
    end
  end
end
