require 'spec_helper'

RSpec.describe BrickFTP::API::History::Folder, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all(path: 'phun') }

    let(:history) do
      [
        {
          'id' => 904_650_651,
          'when' => '2015-10-28T15:50:52-04:00',
          'action' => 'read',
          'path' => 'phun/physics1.png',
          'source' => 'phun/physics1.png',
          'ip' => '86.79.30.9',
          'interface' => 'web',
        },
        {
          'id' => 904_649_269,
          'when' => '2015-10-28T15:48:24-04:00',
          'user_id' => 54_321,
          'username' => 'justice.london',
          'action' => 'read',
          'path' => 'phun/physics1.png',
          'source' => 'phun/physics1.png',
          'ip' => '86.75.30.9',
          'interface' => 'web',
        },
      ]
    end

    before do
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/history/folders/phun')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(body: history.to_json)
    end

    it 'return Array of BrickFTP::API::History::Folder' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::History::Folder))
    end

    it 'set attributes' do
      history = subject
      expect(history.last.id).to eq 904_649_269
      expect(history.last.when).to eq '2015-10-28T15:48:24-04:00'
      expect(history.last.user_id).to eq 54_321
      expect(history.last.username).to eq 'justice.london'
      expect(history.last.action).to eq 'read'
      expect(history.last.path).to eq 'phun/physics1.png'
      expect(history.last.source).to eq 'phun/physics1.png'
      expect(history.last.ip).to eq '86.75.30.9'
      expect(history.last.interface).to eq 'web'
    end
  end
end
