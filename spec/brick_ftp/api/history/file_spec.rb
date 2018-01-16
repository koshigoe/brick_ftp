require 'spec_helper'

RSpec.describe BrickFTP::API::History::File, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all(path: 'archive.zip') }

    let(:history) do
      [
        {
          'id' => 878_672_966,
          'when' => '2015-09-30T18:58:39-04:00',
          'user_id' => 54_321,
          'username' => 'justice.london',
          'action' => 'read',
          'path' => 'archive.zip',
          'source' => 'archive.zip',
          'ip' => '86.75.30.9',
          'interface' => 'sftp',
        },
        {
          'id' => 878_672_238,
          'when' => '2015-09-30T18:58:16-04:00',
          'user_id' => 12_345,
          'username' => 'fred.admin',
          'action' => 'read',
          'path' => 'archive.zip',
          'source' => 'archive.zip',
          'ip' => '172.19.113.171',
          'interface' => 'sftp',
        },
      ]
    end

    before do
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/history/files/archive.zip')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(body: history.to_json)
    end

    it 'return Array of BrickFTP::API::History::File' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::History::File))
    end

    it 'set attributes' do
      history = subject
      expect(history.first.id).to eq 878_672_966
      expect(history.first.when).to eq '2015-09-30T18:58:39-04:00'
      expect(history.first.user_id).to eq 54_321
      expect(history.first.username).to eq 'justice.london'
      expect(history.first.action).to eq 'read'
      expect(history.first.path).to eq 'archive.zip'
      expect(history.first.source).to eq 'archive.zip'
      expect(history.first.ip).to eq '86.75.30.9'
      expect(history.first.interface).to eq 'sftp'
    end
  end
end
