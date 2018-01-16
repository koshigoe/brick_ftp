require 'spec_helper'

RSpec.describe BrickFTP::API::BundleContent, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all(params) }

    context 'success' do
      let(:params) do
        {
          code: 'a0b1c2d3e',
          host: 'justin.brickftp.com',
        }
      end

      let(:request_params) do
        {
          code: 'a0b1c2d3e',
          host: 'justin.brickftp.com',
        }
      end

      let(:contents) do
        [
          {
            'id' => 1,
            'path' => 'cloud',
            'type' => 'directory',
            'size' => nil,
            'crc32' => nil,
            'md5' => nil,
          },
          {
            'id' => 2,
            'path' => 'backup.zip',
            'type' => 'file',
            'size' => 209_715_200,
            'crc32' => '674135a9',
            'md5' => '3389a0b30e05ef6613ccbdae5d9ec0bd',
          },
        ]
      end

      shared_examples_for 'BundleContent' do
        before do
          stub_request(:post, request_url)
            .with(body: request_params.to_json, basic_auth: ['xxxxxxxx', 'x'])
            .to_return(status: 200, body: contents.to_json)
        end

        it 'return instance of BrickFTP::API::BundleContent' do
          is_expected.to all(be_an_instance_of(BrickFTP::API::BundleContent))
        end

        it 'set attributes' do
          contents = subject
          expect(contents.last.id).to eq 2
          expect(contents.last.path).to eq 'backup.zip'
          expect(contents.last.type).to eq 'file'
          expect(contents.last.size).to eq 209_715_200
          expect(contents.last.crc32).to eq '674135a9'
          expect(contents.last.md5).to eq '3389a0b30e05ef6613ccbdae5d9ec0bd'
        end
      end

      context 'without path:' do
        let(:request_url) { 'https://koshigoe.brickftp.com/api/rest/v1/bundles/folders' }
        it_behaves_like 'BundleContent'
      end

      context 'with path:' do
        let(:request_url) { 'https://koshigoe.brickftp.com/api/rest/v1/bundles/folders/path' }
        before { params[:path] = 'path' }
        it_behaves_like 'BundleContent'
      end
    end

    context 'failure' do
      let(:params) { {} }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/bundles/folders')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end
end
