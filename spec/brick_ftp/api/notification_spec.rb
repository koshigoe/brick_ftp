require 'spec_helper'

RSpec.describe BrickFTP::API::Notification, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all }

    let(:notifications) do
      [
        {
          'id' => 2,
          'path' => 'a/b/c',
          'username' => 'stork',
          'user_id' => 5
        },
        {
          'id' => 3,
          'path' => 'a/b',
          'username' => 'zaphod',
          'user_id' => 6
        }
      ]
    end

    before do
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/notifications.json')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(body: notifications.to_json)
    end

    it 'return Array of BrickFTP::API::Notification' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::Notification))
    end

    it 'set attributes' do
      groups = subject
      expect(groups.first.id).to eq 2
      expect(groups.first.path).to eq 'a/b/c'
      expect(groups.first.username).to eq 'stork'
      expect(groups.first.user_id).to eq 5
    end
  end

  describe '.create' do
    subject { described_class.create(params) }

    context 'success' do
      let(:params) do
        {
          'path' => 'a/b/c/d',
          'user_id' => '10'
        }
      end

      let(:notification) do
        {
          'id' => '7',
          'path' => 'a/b/c/d',
          'user_id' => '10',
          'username' => 'fred'
        }
      end

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/notifications.json')
          .with(body: params.to_json, basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 201, body: notification.to_json)
      end

      it 'return instance of BrickFTP::API::Notification' do
        is_expected.to be_an_instance_of BrickFTP::API::Notification
      end

      it 'set attributes' do
        group = subject
        expect(group.id).to eq '7'
        expect(group.path).to eq 'a/b/c/d'
        expect(group.user_id).to eq '10'
        expect(group.username).to eq 'fred'
      end
    end

    context 'failure' do
      let(:params) { { path: 'a' } }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/notifications.json')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end

  describe '#destroy' do
    subject { notification.destroy }

    let(:notification) { described_class.new(id: 125_108) }

    before do
      stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/notifications/125108.json')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(body: '[]')
    end

    it 'return true' do
      is_expected.to eq true
    end
  end
end
