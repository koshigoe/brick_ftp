# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetSiteUsage, type: :lib do
  describe '#call' do
    context 'given correct Site ID' do
      it 'return Site object' do
        expected_site_usage = BrickFTP::Types::SiteUsage.new(
          id: 107_748,
          live_current_storage: 11_731_830,
          current_storage: 655_370,
          usage_by_top_level_dir: [
            ['koshigoe-user01', 65_536],
            ['koshigoe-user04', 65_536],
            ['a b', 262_149],
            ['b c', 65_536],
            ['* Files In Root Folder', 0],
            ['* Files Deleted But Retained As Backups Under Your Backup Settings', 131_077],
            ['* Files Deleted But Uploaded Within Past 30 Days (minimum file billing length)', 0],
          ],
          high_water_storage: 655_370,
          start_at: '2018-08-17T02:59:44-04:00',
          end_at: nil,
          created_at: '2018-08-17T02:59:45-04:00',
          updated_at: '2018-08-24T05:50:03-04:00',
          total_uploads: 5,
          total_downloads: 0
        )

        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/site/usage.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: expected_site_usage.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetSiteUsage.new(rest)

        expect(command.call).to eq expected_site_usage
      end
    end
  end
end
