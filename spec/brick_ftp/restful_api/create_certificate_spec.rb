# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateCertificate, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Certificate object' do
        created_certificate = BrickFTP::Types::Certificate.new(
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

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/certificates.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              name: 'Name',
              certificate_domain: 'domain.com',
              key_type: 'RSA-4096',
              certificate: '[certificate]',
              intermediates: '[certificates]',
            }.to_json
          )
          .to_return(body: created_certificate.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateCertificate::Params.new(
          name: 'Name',
          certificate_domain: 'domain.com',
          key_type: 'RSA-4096',
          certificate: '[certificate]',
          intermediates: '[certificates]'
        )
        command = BrickFTP::RESTfulAPI::CreateCertificate.new(rest)

        expect(command.call(params)).to eq created_certificate
      end
    end
  end
end
