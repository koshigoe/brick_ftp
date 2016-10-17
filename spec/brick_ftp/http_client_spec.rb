require 'spec_helper'

RSpec.describe BrickFTP::HTTPClient, type: :lib do
  before do
    BrickFTP.configure do |c|
      c.subdomain = 'koshigoe'
      c.api_key = 'xxxxxxxx'
    end
  end

  describe '#get' do
    subject { described_class.new.get(path) }

    let(:path) { '/api/rest/v1/users.json' }

    context 'HTTP 200 OK' do
      before do
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/users.json')
          .with(
            basic_auth: ['xxxxxxxx', 'x'],
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)' }
          )
          .to_return(body: { id: 'xxxxxxxx' }.to_json)
      end

      it 'return data' do
        is_expected.to eq('id' => 'xxxxxxxx')
      end
    end

    context 'Other' do
      before do
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/users.json')
          .with(
            basic_auth: ['xxxxxxxx', 'x'],
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)' }
          )
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end

    context 'Error response with empty array' do
      before do
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/users.json')
          .with(
            basic_auth: ['xxxxxxxx', 'x'],
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)' }
          )
          .to_return(status: [422, 'Unprocessable Entity'], body: '[]')
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end

      it 'message of exception is HTTP Status-Line' do
        expect { subject }.to raise_error(BrickFTP::HTTPClient::Error) do |ex|
          expect(ex.message).to eq('422 Unprocessable Entity')
        end
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
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)' }
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
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)' }
          )
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end

    context 'Error response with empty array' do
      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(
            body: { username: 'koshigoe', password: 'password' }.to_json,
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)' }
          )
          .to_return(status: [422, 'Unprocessable Entity'], body: '[]')
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end

      it 'message of exception is HTTP Status-Line' do
        expect { subject }.to raise_error(BrickFTP::HTTPClient::Error) do |ex|
          expect(ex.message).to eq('422 Unprocessable Entity')
        end
      end
    end
  end

  describe '#put' do
    subject { described_class.new.put(path, params: params) }

    let(:path) { '/api/rest/v1/sessions.json' }
    let(:params) { { username: 'koshigoe', password: 'password' } }

    context 'HTTP 200 OK' do
      before do
        stub_request(:put, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(
            basic_auth: ['xxxxxxxx', 'x'],
            body: { username: 'koshigoe', password: 'password' }.to_json,
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)' }
          )
          .to_return(status: 200, body: { id: 'xxxxxxxx' }.to_json)
      end

      it 'return data' do
        is_expected.to eq('id' => 'xxxxxxxx')
      end
    end

    context 'Other' do
      before do
        stub_request(:put, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(
            basic_auth: ['xxxxxxxx', 'x'],
            body: { username: 'koshigoe', password: 'password' }.to_json,
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)' }
          )
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end

    context 'Error response with empty array' do
      before do
        stub_request(:put, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(
            basic_auth: ['xxxxxxxx', 'x'],
            body: { username: 'koshigoe', password: 'password' }.to_json,
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)' }
          )
          .to_return(status: [422, 'Unprocessable Entity'], body: '[]')
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end

      it 'message of exception is HTTP Status-Line' do
        expect { subject }.to raise_error(BrickFTP::HTTPClient::Error) do |ex|
          expect(ex.message).to eq('422 Unprocessable Entity')
        end
      end
    end
  end

  describe '#delete' do
    subject { described_class.new.delete(path) }

    let(:path) { '/api/rest/v1/sessions.json' }

    context 'HTTP 200 OK' do
      before do
        stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(
            basic_auth: ['xxxxxxxx', 'x'],
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)' }
          )
          .to_return(status: 200, body: '[]')
      end

      it 'return true' do
        is_expected.to eq true
      end
    end

    context 'Other' do
      before do
        stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(
            basic_auth: ['xxxxxxxx', 'x'],
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)' }
          )
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end

    context 'Error response with empty array' do
      before do
        stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(
            basic_auth: ['xxxxxxxx', 'x'],
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)' }
          )
          .to_return(status: [422, 'Unprocessable Entity'], body: '[]')
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end

      it 'message of exception is HTTP Status-Line' do
        expect { subject }.to raise_error(BrickFTP::HTTPClient::Error) do |ex|
          expect(ex.message).to eq('422 Unprocessable Entity')
        end
      end
    end
  end
end
