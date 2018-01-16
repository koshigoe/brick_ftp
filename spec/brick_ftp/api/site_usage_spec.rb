require 'spec_helper'

RSpec.describe BrickFTP::API::SiteUsage, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.find' do
    subject { described_class.find }

    before do
      usage = {
        'id' => 12_345,
        'live_current_storage' => 367_270_573,
        'current_storage' => 367_270_573,
        'usage_by_top_level_dir' => [
          [
            'Images',
            189_998_503,
          ],
          [
            'Documents',
            65_536,
          ],
          [
            'Music',
            5_701_171,
          ],
          [
            'Sales',
            1_988_464,
          ],
          [
            'Code',
            232_131,
          ],
          [
            'Other',
            1_141_220,
          ],
          [
            '* Files In Root Folder',
            65_596,
          ],
          [
            '* Files Deleted But Retained As Backups Under Your Backup Settings',
            0,
          ],
          [
            '* Files Deleted But Uploaded Within Past 30 Days (minimum file billing length)',
            168_012_416,
          ],
        ],
        'high_water_storage' => 8_062_401_756,
        'start_at' => '2015-05-28T12:22:15-04:00',
        'end_at' => nil,
        'created_at' => '2015-05-28T12:22:15-04:00',
        'updated_at' => '2016-10-19T00:10:02-04:00',
      }
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/site/usage')
        .with(basic_auth: %w[xxxxxxxx x])
        .to_return(body: usage.to_json)
    end

    it 'return instance of BrickFTP::API::SiteUsage' do
      is_expected.to be_an_instance_of BrickFTP::API::SiteUsage
    end

    it 'set attributes' do
      usage = subject
      expect(usage.id).to eq 12_345
      expect(usage.live_current_storage).to eq 367_270_573
      expect(usage.current_storage).to eq 367_270_573
      usage_by_top_level_dir = [
        ['Images', 189_998_503],
        ['Documents', 65_536],
        ['Music', 5_701_171],
        ['Sales', 1_988_464],
        ['Code', 232_131],
        ['Other', 1_141_220],
        ['* Files In Root Folder', 65_596],
        ['* Files Deleted But Retained As Backups Under Your Backup Settings', 0],
        ['* Files Deleted But Uploaded Within Past 30 Days (minimum file billing length)', 168_012_416],
      ]
      expect(usage.usage_by_top_level_dir).to eq usage_by_top_level_dir
      expect(usage.high_water_storage).to eq 8_062_401_756
      expect(usage.start_at).to eq '2015-05-28T12:22:15-04:00'
      expect(usage.end_at).to eq nil
      expect(usage.created_at).to eq '2015-05-28T12:22:15-04:00'
      expect(usage.updated_at).to eq '2016-10-19T00:10:02-04:00'
    end
  end
end
