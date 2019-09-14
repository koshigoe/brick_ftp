# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListIpAddresses, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of IpAddress object' do
        expected_ip_address = BrickFTP::Types::IpAddress.new(
          associated_with: 'Site',
          group_id: 1,
          ip_addresses: []
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/site/ip_addresses.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_ip_address.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListIpAddresses.new(rest)

        expect(command.call).to eq([expected_ip_address])
      end
    end
  end
end
