require 'spec_helper'

RSpec.describe BrickFTP::API::PublicKey, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all(user_id: 1) }

    before do
      public_keys = [
        {
          'id' => 1217,
          'title' => 'TEST',
          'fingerprint' => '1b:11:87:39:5c:88:05:ec:cc:41:33:90:b0:70:e2:8b',
          'created_at' => '2016-09-30T01:14:26-04:00',
        },
      ]
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/users/1/public_keys.json')
        .with(basic_auth: %w[xxxxxxxx x])
        .to_return(body: public_keys.to_json)
    end

    it 'return Array of BrickFTP::API::PublicKey' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::PublicKey))
    end

    it 'set attributes' do
      public_keys = subject
      expect(public_keys.first.id).to eq 1217
      expect(public_keys.first.title).to eq 'TEST'
      expect(public_keys.first.fingerprint).to eq '1b:11:87:39:5c:88:05:ec:cc:41:33:90:b0:70:e2:8b'
      expect(public_keys.first.created_at).to eq '2016-09-30T01:14:26-04:00'
    end
  end

  describe '.create' do
    subject { described_class.create(params) }

    let(:params) { path_params.merge(attributes) }
    let(:path_params) { { user_id: 1 } }
    let(:attributes) { { title: 'new key', public_key: public_key } }
    let(:public_key) { 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0bhSqoXErPk7tvtmjw2xD6+ql/yg/0I3K+jC+q2nkmrg34gU9tk9eG38wuALMT4MyP3iW9os3c1A4MwBZRnmuBAEBvmHMFKvEvWE2txxBZ9FZJU2KOg0kWnOFrPbIk1Eu+ndkbaJg8T2D4kJXfKtx6C/ArYlJqkA24wlxA/kTkwzJFFs9CqpYJPEVkut+JoecfW7LKiPIxEt+8wLuKLAwz83mtzW/s3oma0H5z5z5TAP96Yim9bGAL+AgY0qsJZKhzc0fcQ0B80BDO7XbdOipffCRmb0UuiK4OC5Z7va1XD5PkAIo143eg4mU57RskfXbHR5NLrt2ozdXCXLmavrh' }

    before do
      public_key = {
        'id' => 1217,
        'title' => 'TEST',
        'fingerprint' => '1b:11:87:39:5c:88:05:ec:cc:41:33:90:b0:70:e2:8b',
        'created_at' => '2016-09-30T01:14:26-04:00',
      }
      stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/users/1/public_keys.json')
        .with(body: attributes.to_json, basic_auth: %w[xxxxxxxx x])
        .to_return(status: 201, body: public_key.to_json)
    end

    it 'return Array of BrickFTP::API::PublicKey' do
      is_expected.to be_an_instance_of(BrickFTP::API::PublicKey)
    end

    it 'set attributes' do
      public_key = subject
      expect(public_key.id).to eq 1217
      expect(public_key.title).to eq 'TEST'
      expect(public_key.fingerprint).to eq '1b:11:87:39:5c:88:05:ec:cc:41:33:90:b0:70:e2:8b'
      expect(public_key.created_at).to eq '2016-09-30T01:14:26-04:00'
    end
  end

  describe '#destroy' do
    subject { public_key.destroy }

    let(:public_key) do
      described_class.new(
        id: 1,
        title: 'key',
        fingerprint: '1b:11:87:39:5c:88:05:ec:cc:41:33:90:b0:70:e2:8b',
        created_at: '2016-09-30T01:14:26-04:00'
      )
    end

    before do
      stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/public_keys/1.json')
        .with(basic_auth: %w[xxxxxxxx x])
        .to_return(body: '[]')
    end

    it 'return true' do
      is_expected.to eq true
    end
  end
end
