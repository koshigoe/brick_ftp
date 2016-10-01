require 'spec_helper'

RSpec.describe BrickFTP::HTTPClient, type: :lib do
  before do
    BrickFTP.configure { |c| c.subdomain = 'koshigoe' }
  end

  describe '#get' do
    subject { described_class.new.get(path) }

    let(:path) { '/api/rest/v1/users.json' }

    context 'HTTP 200 OK' do
      before do
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/users.json')
          .to_return(body: { id: 'xxxxxxxx' }.to_json)
      end

      it 'return data' do
        is_expected.to eq('id' => 'xxxxxxxx')
      end
    end

    context 'Other' do
      before do
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/users.json')
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end

  describe '#post' do
    subject { described_class.new.post(path, params: params) }

    let(:path) { '/api/rest/v1/sessions.json' }
    let(:params) { { username: 'koshigoe', password: 'password' } }

    context 'HTTP 201 Created' do
      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(
            body: { username: 'koshigoe', password: 'password' }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
          .to_return(status: 201, body: { id: 'xxxxxxxx' }.to_json)
      end

      it 'return data' do
        is_expected.to eq('id' => 'xxxxxxxx')
      end
    end

    context 'Other' do
      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(
            body: { username: 'koshigoe', password: 'password' }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end

  describe '#delete' do
    subject { described_class.new.delete(path) }

    let(:path) { '/api/rest/v1/sessions.json' }

    context 'HTTP 200 OK' do
      before do
        stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .to_return(status: 200, body: '[]')
      end

      it 'return true' do
        is_expected.to eq true
      end
    end

    context 'Other' do
      before do
        stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end
end
