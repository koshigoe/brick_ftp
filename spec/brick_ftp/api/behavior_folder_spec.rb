require 'spec_helper'

RSpec.describe BrickFTP::API::FolderBehavior, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all(path: 'Incoming', recursive: 1) }

    let(:behaviors) do
      [
        {
          'id' => 44,
          'path' => 'Incoming',
          'behavior' => 'webhook',
          'value' => [
            'https://a.mywebhookhandler.com',
          ],
        },
        {
          'id' => 45,
          'path' => 'Incoming',
          'behavior' => 'webhook',
          'value' => [
            'https://b.mywebhookhandler.com',
          ],
        },
      ]
    end

    before do
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/behaviors/folders/Incoming?recursive=1')
        .with(basic_auth: %w[xxxxxxxx x])
        .to_return(status: 200, body: behaviors.to_json)
    end

    it 'return instance of BrickFTP::API::FolderBehavior' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::FolderBehavior))
    end

    it 'set attributes' do
      downloads = subject
      expect(downloads.first.id).to eq 44
      expect(downloads.first.path).to eq 'Incoming'
      expect(downloads.first.behavior).to eq 'webhook'
      expect(downloads.first.value).to eq %w[https://a.mywebhookhandler.com]
    end
  end
end
