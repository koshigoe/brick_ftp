require 'spec_helper'

RSpec.describe BrickFTP::Authentication::Session, type: :lib do
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

      it 'return instance of BrickFTP::Authentication::Session' do
        is_expected.to be_an_instance_of BrickFTP::Authentication::Session
      end

      it 'store id' do
        expect(subject.id).to eq 'xxxxxxxx'
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
end
