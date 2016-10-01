require 'spec_helper'

RSpec.describe BrickFTP::API::User, type: :lib do
  describe '.all' do
    subject { described_class.all }

    before do
      BrickFTP.configure do |c|
        c.subdomain = 'koshigoe'
        c.api_key = 'xxxxxxxx'
      end

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
end
