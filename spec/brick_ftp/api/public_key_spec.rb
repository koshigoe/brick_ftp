require 'spec_helper'

RSpec.describe BrickFTP::API::PublicKey, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all(1) }

    before do
      public_keys = [
        {
          "id" => 1217,
          "title" => "TEST",
          "fingerprint" => "1b:11:87:39:5c:88:05:ec:cc:41:33:90:b0:70:e2:8b",
          "created_at" => "2016-09-30T01:14:26-04:00"
        }
      ]
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/users/1/public_keys.json')
        .with(basic_auth: ['xxxxxxxx', 'x'])
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
end
