require 'spec_helper'

RSpec.describe BrickFTP::API::Authentication::Session, type: :lib do
  before do
    BrickFTP.configure { |c| c.subdomain = 'koshigoe' }
  end

  describe '.create' do
    context 'valid parameter' do
      subject { described_class.create('koshigoe', 'password') }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(
            body: { username: 'koshigoe', password: 'password' }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
          .to_return(status: 201, body: { id: 'xxxxxxxx' }.to_json)
      end

      it 'return instance of BrickFTP::API::Authentication::Session' do
        is_expected.to be_an_instance_of BrickFTP::API::Authentication::Session
      end

      it 'store id' do
        expect(subject.id).to eq 'xxxxxxxx'
      end

      it 'set session to configuration' do
        session = subject
        expect(BrickFTP.config.session).to eq session
      end
    end

    context 'invalid parameter' do
      subject { described_class.create('', '') }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(
            body: { username: '', password: '' }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end

  describe '#destroy' do
    subject { session.destroy }

    let(:session) { described_class.new(id: 'xxxxxxxx') }

    before { BrickFTP.config.session = session }

    context 'success' do
      before do
        stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(headers: { 'Cookie' => 'BrickFTP=xxxxxxxx; path=' })
          .to_return(body: '[]')
      end

      it 'clear session id' do
        expect { subject }.to change(session, :id).to(nil)
      end

      it 'unset session from configuration' do
        expect { subject }.to change(BrickFTP.config, :session).to(nil)
      end
    end

    context 'failure' do
      before do
        stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/sessions.json')
          .with(headers: { 'Cookie' => 'BrickFTP=xxxxxxxx; path=' })
          .to_return(status: 500, body: { 'error' => 'xxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end
end
