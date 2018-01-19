require 'spec_helper'

RSpec.describe BrickFTP::API::FileOperation::UploadingResult, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.create' do
    subject { described_class.create(path: 'NewFile.txt', ref: 'put-378670') }

    context 'success' do
      let(:body) do
        {
          'path' => 'NewFile.txt',
          'type' => 'file',
          'size' => 412,
          'mtime' => '2014-05-17T05:14:35+00:00',
          'crc32' => nil,
          'md5' => nil,
        }
      end

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
          .with(basic_auth: %w[xxxxxxxx x], body: { action: 'end', ref: 'put-378670' }.to_json)
          .to_return(status: 200, body: body.to_json)
      end

      it 'return instance of BrickFTP::API::FileOperation::Upload' do
        is_expected.to be_an_instance_of BrickFTP::API::FileOperation::UploadingResult
      end

      it 'set attributes' do
        upload = subject
        expect(upload.type).to eq 'file'
        expect(upload.size).to eq 412
        expect(upload.mtime).to eq '2014-05-17T05:14:35+00:00'
        expect(upload.crc32).to eq nil
        expect(upload.md5).to eq nil
      end
    end

    context 'failure' do
      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
          .with(basic_auth: %w[xxxxxxxx x], body: { action: 'end', ref: 'put-378670' }.to_json)
          .to_return(status: 500, body: '')
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end
end
