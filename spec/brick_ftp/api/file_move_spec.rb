require 'spec_helper'

RSpec.describe BrickFTP::API::FileMove, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.create' do
    subject { described_class.create(params, path: 'path') }

    context 'success' do
      let(:params) { { 'move-destination' => '/DESTINATION_PATH_AND_FILENAME.EXT' } }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/path')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 200, body: '[]')
      end

      it 'return instance of BrickFTP::API::FileMove' do
        is_expected.to be_an_instance_of BrickFTP::API::FileMove
      end
    end

    context 'failure' do
      let(:params) { {} }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/path')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end
end
