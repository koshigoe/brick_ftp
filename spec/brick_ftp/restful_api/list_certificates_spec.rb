# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListCertificates, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of Certificate object' do
        expected_certificate = BrickFTP::Types::Certificate.new(
          id: 1,
          certificate: '[certificate]',
          created_at: '2000-01-01 01:00:00 UTC',
          display_status: 'Available',
          domains: [],
          expires_at: '2000-01-01 01:00:00 UTC',
          brick_managed: true,
          intermediates: '[certificates]',
          ip_addresses: [],
          issuer: '',
          name: 'My Certificate',
          key_type: 'RSA-4096',
          request: '[CSR]',
          status: 'Available',
          subject: 'my-custom-domain.com',
          updated_at: '2000-01-01 01:00:00 UTC'
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/certificates.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_certificate.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListCertificates.new(rest)

        expect(command.call).to eq([expected_certificate])
      end
    end
  end
end
