require 'spec_helper'

RSpec.describe BrickFTP::API::Permission, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all }

    let(:permissions) do
      [
        {
          "id" => 2,
          "path" => "a/b/c",
          "permission" => "writeonly",
          "group_id" => nil,
          "user_id" => 5
        },
        {
          "id" => 3,
          "path" => "a/b",
          "permission" => "readonly",
          "group_id" => 2,
          "user_id" => nil
        }
      ]
    end

    before do
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/permissions.json')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(body: permissions.to_json)
    end

    it 'return Array of BrickFTP::API::Permission' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::Permission))
    end

    it 'set attributes' do
      groups = subject
      expect(groups.first.id).to eq 2
      expect(groups.first.path).to eq "a/b/c"
      expect(groups.first.permission).to eq "writeonly"
      expect(groups.first.group_id).to eq nil
      expect(groups.first.user_id).to eq 5
    end
  end

  describe '.create' do
    subject { described_class.create(params) }

    context 'success' do
      let(:params) do
        {
          "path" => "a/b/c/d",
          "permission" => "writeonly",
          "user_id" => "10"
        }
      end

      let(:permission) do
        {
          "id" => 3,
          "path" => "a/b/c/d",
          "permission" => "writeonly",
          "group_id" => nil,
          "user_id" => 10
        }
      end

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/permissions.json')
          .with(body: params.to_json, basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 201, body: permission.to_json)
      end

      it 'return instance of BrickFTP::API::Permission' do
        is_expected.to be_an_instance_of BrickFTP::API::Permission
      end

      it 'set attributes' do
        group = subject
        expect(group.id).to eq 3
        expect(group.path).to eq "a/b/c/d"
        expect(group.permission).to eq "writeonly"
        expect(group.group_id).to eq nil
        expect(group.user_id).to eq 10
      end
    end

    context 'failure' do
      let(:params) { { path: 'a' } }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/permissions.json')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end

  describe '#destroy' do
    subject { permission.destroy }

    let(:permission) { described_class.new(id: 125108) }

    before do
      stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/permissions/125108.json')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(body: '[]')
    end

    it 'return true' do
      is_expected.to eq true
    end
  end
end
