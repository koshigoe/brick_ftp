require 'spec_helper'

RSpec.describe BrickFTP::API::History::User, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all(user_id: 1) }

    let(:history) do
      [
        {
          'id' => 903_767_970,
          'when' => '2015-10-27T15:09:55-04:00',
          'user_id' => 54_321,
          'username' => 'justice.london',
          'action' => 'create',
          'path' => 'accounts.xls',
          'destination' => 'accounts.xls',
          'ip' => '86.75.30.9',
          'interface' => 'ftp',
        },
        {
          'id' => 903_766_146,
          'when' => '2015-10-27T15:05:55-04:00',
          'user_id' => 54_321,
          'username' => 'justice.london',
          'action' => 'login',
          'ip' => '86.75.30.9',
          'interface' => 'ftp',
        },
      ]
    end

    before do
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/history/users/1.json')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(body: history.to_json)
    end

    it 'return Array of BrickFTP::API::History::User' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::History::User))
    end

    it 'set attributes' do
      history = subject
      expect(history.first.id).to eq 903_767_970
      expect(history.first.when).to eq '2015-10-27T15:09:55-04:00'
      expect(history.first.user_id).to eq 54_321
      expect(history.first.username).to eq 'justice.london'
      expect(history.first.action).to eq 'create'
      expect(history.first.path).to eq 'accounts.xls'
      expect(history.first.destination).to eq 'accounts.xls'
      expect(history.first.ip).to eq '86.75.30.9'
      expect(history.first.interface).to eq 'ftp'
    end
  end
end
