# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::API::BundleDownload, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all(params) }

    context 'success' do
      let(:params) do
        {
          'code' => 'a0b1c2d3e',
          'host' => 'justin.brickftp.com',
          'paths' => [
            'cloud/images/image1.jpg',
            'backup.zip',
          ],
        }
      end

      let(:downloads) do
        [
          {
            'id' => 1,
            'path' => 'cloud/images/image1.jpg',
            'type' => 'file',
            'size' => 842_665,
            'crc32' => 'bb9d7277',
            'md5' => '9a3ec51abac56e35d2865b376c9658ec',
            # rubocop:disable Metrics/LineLength
            'download_uri' => "https://s3.amazonaws.com/objects.brickftp.com/metadata/10099/2e2376c0-7527-0133-21fb-0a2d4abb99a7?AWSAccessKeyId=AKIAIEWLY3MN4YGZQOWA\u0026Signature=spXByI%2BBFThcB%2FwFkPUZcIXtRzE%3D\u0026Expires=1448404172\u0026response-content-disposition=attachment;%20filename=%22image1.jpg%22",
            # rubocop:enable Metrics/LineLength
          },
          {
            'id' => 2,
            'path' => 'backup.zip',
            'type' => 'file',
            'size' => 209_715_200,
            'crc32' => '674135a9',
            'md5' => '3389a0b30e05ef6613ccbdae5d9ec0bd',
            # rubocop:disable Metrics/LineLength
            'download_uri' => "https://s3.amazonaws.com/objects.brickftp.com/metadata/10099/dbf4f3d0-4a7a-0133-bd45-0ea6408b29c1?AWSAccessKeyId=AKIAIEWLY3MN4YGZQOWA\u0026Signature=ArRo7x7It2%2BQQwCmiapwTFAJBSE%3D\u0026Expires=1448404172\u0026response-content-disposition=attachment;%20filename=%22backup.zip%22",
            # rubocop:enable Metrics/LineLength
          },
        ]
      end

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/bundles/files.json')
          .with(body: params.to_json, basic_auth: %w[xxxxxxxx x])
          .to_return(status: 200, body: downloads.to_json)
      end

      it 'return instance of BrickFTP::API::BundleDownload' do
        is_expected.to all(be_an_instance_of(BrickFTP::API::BundleDownload))
      end

      it 'set attributes' do
        downloads = subject
        expect(downloads.last.id).to eq 2
        expect(downloads.last.path).to eq 'backup.zip'
        expect(downloads.last.type).to eq 'file'
        expect(downloads.last.size).to eq 209_715_200
        expect(downloads.last.crc32).to eq '674135a9'
        expect(downloads.last.md5).to eq '3389a0b30e05ef6613ccbdae5d9ec0bd'
        # rubocop:disable Metrics/LineLength
        expect(downloads.last.download_uri).to eq "https://s3.amazonaws.com/objects.brickftp.com/metadata/10099/dbf4f3d0-4a7a-0133-bd45-0ea6408b29c1?AWSAccessKeyId=AKIAIEWLY3MN4YGZQOWA\u0026Signature=ArRo7x7It2%2BQQwCmiapwTFAJBSE%3D\u0026Expires=1448404172\u0026response-content-disposition=attachment;%20filename=%22backup.zip%22"
        # rubocop:enable Metrics/LineLength
      end
    end

    context 'failure' do
      let(:params) { {} }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/bundles/files.json')
          .with(basic_auth: %w[xxxxxxxx x])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end
end
