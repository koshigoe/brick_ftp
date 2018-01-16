require 'spec_helper'

RSpec.describe BrickFTP::API::History::Site, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all(pagination_params) }

    let(:pagination_params) do
      {
        page: 1,
        per_page: 2,
        start_at: '2015-09-19T22:30:20-04:00',
      }
    end

    let(:history) do
      [
        {
          "id" => 869831023,
          "when" => "2015-09-19T22:30:20-04:00",
          "user_id" => 12345,
          "username" => "fred.admin",
          "action" => "login",
          "ip" => "172.19.113.171",
          "interface" => "ftp"
        },
        {
          "id" => 814350298,
          "when" => "2015-06-25T14:32:20-04:00",
          "user_id" => 12345,
          "username" => "fred.admin",
          "action" => "permission_create",
          "path" => "Files for bob.user",
          "source" => "Files for bob.user",
          "targets" => {
            "user" => {
              "id" => 23451,
              "username" => "bob.user"
            },
            "permission" => {
              "id" => 67543,
              "permission" => "full",
              "recursive" => true
            }
          },
          "ip" => "172.19.113.171",
          "interface" => "web"
        }
      ]
    end

    before do
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/history.json?page=1&per_page=2&start_at=2015-09-19T22%3A30%3A20-04%3A00')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(body: history.to_json)
    end

    it 'return Array of BrickFTP::API::History::Site' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::History::Site))
    end

    it 'set attributes' do
      history = subject
      expect(history.last.id).to eq 814350298
      expect(history.last.when).to eq '2015-06-25T14:32:20-04:00'
      expect(history.last.user_id).to eq 12345
      expect(history.last.username).to eq 'fred.admin'
      expect(history.last.action).to eq 'permission_create'
      expect(history.last.path).to eq 'Files for bob.user'
      expect(history.last.source).to eq 'Files for bob.user'
      expect(history.last.targets)
        .to eq(
              "user" => {
                "id" => 23451,
                "username" => "bob.user"
              },
              "permission" => {
                "id" => 67543,
                "permission" => "full",
                "recursive" => true
              }
        )
      expect(history.last.ip).to eq '172.19.113.171'
      expect(history.last.interface).to eq 'web'
    end
  end
end
