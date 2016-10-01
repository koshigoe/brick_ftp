require 'spec_helper'

RSpec.describe BrickFTP::API::User, type: :lib do
  before do
    BrickFTP.configure do |c|
      c.subdomain = 'koshigoe'
      c.api_key = 'xxxxxxxx'
    end
  end

  describe '.all' do
    subject { described_class.all }

    before do
      users = [
        {
          "id" => 2,
          "username" => "stork",
          "name" => "John",
          "email" => "",
          "notes" => "",
          "group_ids" => "2",
          "ftp_permission" => true,
          "web_permission" => true,
          "sftp_permission" => true,
          "dav_permission" => true,
          "restapi_permission" => true,
          "attachments_permission" => true,
          "self_managed" => true,
          "require_password_change" => false,
          "allowed_ips" => "",
          "user_root" => "API"
        },
        {
          "id" => 3,
          "username" => "zaphod",
          "name" => "Zaphod Beeblebrox",
          "email" => "towel@example.com",
          "notes" => "",
          "group_ids" => "1",
          "ftp_permission" => true,
          "web_permission" => true,
          "sftp_permission" => true,
          "dav_permission" => true,
          "restapi_permission" => true,
          "attachments_permission" => true,
          "self_managed" => true,
          "require_password_change" => false,
          "allowed_ips" => "",
          "user_root" => "Zaphod"
        }
      ]
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/users.json')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(body: users.to_json)
    end

    it 'return Array of BrickFTP::API::User' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::User))
    end

    it 'set attributes' do
      users = subject
      expect(users.first.id).to eq 2
      expect(users.first.username).to eq "stork"
      expect(users.first.name).to eq "John"
      expect(users.first.email).to eq ""
      expect(users.first.notes).to eq ""
      expect(users.first.group_ids).to eq "2"
      expect(users.first.ftp_permission).to eq true
      expect(users.first.web_permission).to eq true
      expect(users.first.sftp_permission).to eq true
      expect(users.first.dav_permission).to eq true
      expect(users.first.restapi_permission).to eq true
      expect(users.first.attachments_permission).to eq true
      expect(users.first.self_managed).to eq true
      expect(users.first.require_password_change).to eq false
      expect(users.first.allowed_ips).to eq ""
      expect(users.first.user_root).to eq "API"
    end
  end

  describe '.find' do
    subject { described_class.find(2) }

    context 'exists' do
      before do
        user = {
          "id" => 2,
          "username" => "stork",
          "name" => "John",
          "email" => "",
          "notes" => "",
          "group_ids" => "2",
          "ftp_permission" => true,
          "web_permission" => true,
          "sftp_permission" => true,
          "dav_permission" => true,
          "restapi_permission" => true,
          "attachments_permission" => true,
          "self_managed" => true,
          "require_password_change" => false,
          "allowed_ips" => "",
          "user_root" => "API"
        }
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/users/2.json')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(body: user.to_json)
      end

      it 'return instance of BrickFTP::API::User' do
        is_expected.to be_an_instance_of BrickFTP::API::User
      end

      it 'set attributes' do
        user = subject
        expect(user.id).to eq 2
        expect(user.username).to eq "stork"
        expect(user.name).to eq "John"
        expect(user.email).to eq ""
        expect(user.notes).to eq ""
        expect(user.group_ids).to eq "2"
        expect(user.ftp_permission).to eq true
        expect(user.web_permission).to eq true
        expect(user.sftp_permission).to eq true
        expect(user.dav_permission).to eq true
        expect(user.restapi_permission).to eq true
        expect(user.attachments_permission).to eq true
        expect(user.self_managed).to eq true
        expect(user.require_password_change).to eq false
        expect(user.allowed_ips).to eq ""
        expect(user.user_root).to eq "API"
      end
    end

    context 'not exists' do
      before do
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/users/2.json')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(body: '[]')
      end

      it 'return nil' do
        is_expected.to be_nil
      end
    end
  end

  describe '.create' do
    subject { described_class.create(params) }

    context 'success' do
      let(:params) do
        {
          username: "johndoe",
          password: "doejohn123",
          name: "John Doe",
          email: "john@example.com",
          notes: "CTO",
          group_ids: "3,4",
          ftp_permission: true,
          web_permission: true,
          sftp_permission: true,
          dav_permission: true,
          restapi_permission: true,
          attachments_permission: false,
          self_managed: true,
          require_password_change: false,
          allowed_ips: "",
          user_root: "",
          grant_permission: "read"
        }
      end

      before do
        body = {
          "id" => 125108,
          "username" => "johndoe",
          "authentication_method" => "password",
          "last_login_at" => nil,
          "name" => "John Doe",
          "email" => "john@example.com",
          "notes" => "CTO",
          "group_ids" => "3,4",
          "ftp_permission" => true,
          "web_permission" => true,
          "sftp_permission" => true,
          "dav_permission" => true,
          "restapi_permission" => true,
          "attachments_permission" => true,
          "self_managed" => true,
          "require_password_change" => false,
          "allowed_ips" => nil,
          "user_root" => nil,
          "time_zone" => "Eastern Time (US & Canada)",
          "language" => "",
          "ssl_required" => "use_system_setting",
          "site_admin" => false,
        }
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/users.json')
          .with(body: params.to_json, basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 201, body: body.to_json)
      end

      it 'return instance of User' do
        is_expected.to be_an_instance_of BrickFTP::API::User
      end

      it 'set attributes' do
        user = subject
        expect(user.id).to eq 125108
        expect(user.username).to eq "johndoe"
        expect(user.authentication_method).to eq "password"
        expect(user.last_login_at).to eq nil
        expect(user.name).to eq "John Doe"
        expect(user.email).to eq "john@example.com"
        expect(user.notes).to eq "CTO"
        expect(user.group_ids).to eq "3,4"
        expect(user.ftp_permission).to eq true
        expect(user.web_permission).to eq true
        expect(user.sftp_permission).to eq true
        expect(user.dav_permission).to eq true
        expect(user.restapi_permission).to eq true
        expect(user.attachments_permission).to eq true
        expect(user.self_managed).to eq true
        expect(user.require_password_change).to eq false
        expect(user.allowed_ips).to eq nil
        expect(user.user_root).to eq nil
        expect(user.time_zone).to eq "Eastern Time (US & Canada)"
        expect(user.language).to eq ""
        expect(user.ssl_required).to eq "use_system_setting"
        expect(user.site_admin).to eq false
      end
    end

    context 'failure' do
      let(:params) { { username: 'koshigoe' } }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/users.json')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end
end
