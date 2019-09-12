# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::UpdateCertificate, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return updated Certificate object' do
        updated_certificate = BrickFTP::Types::Certificate.new(
          id: 1,
          behavior: 'webhook',
          path: 'webhook',
          value: {
            'method' => 'GET',
          }
        )

        stub_request(:patch, 'https://subdomain.files.com/api/rest/v1/certificates/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              name: 'My Certificate',
              intermediates: '[certificates]',
              certificate: '[certificate]',
            }.to_json
          )
          .to_return(body: updated_certificate.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::UpdateCertificate::Params.new(
          name: 'My Certificate',
          intermediates: '[certificates]',
          certificate: '[certificate]'
        )
        command = BrickFTP::RESTfulAPI::UpdateCertificate.new(rest)

        expect(command.call(1234, params)).to eq updated_certificate
      end
    end
  end
end
