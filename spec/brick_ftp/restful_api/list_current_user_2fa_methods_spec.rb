# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListCurrentUser2faMethods, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of TwoFactorAuthenticationMethod object' do
        expected_2fa = BrickFTP::Types::TwoFactorAuthenticationMethod.new(
          id: 1,
          method_type: 'yubi',
          name: 'Yubikey',
          phone_number: '(555) 555-5555',
          phone_number_country: 'US',
          phone_number_national_format: '+15555555555',
          setup_expired: true,
          setup_complete: true,
          setup_expires_at: '2000-01-01 01:00:00 UTC',
          totp_provisioning_uri: 'https://...',
          u2f_app_id: 'app id',
          u2f_registration_requests: []
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/2fa.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_2fa.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListCurrentUser2faMethods.new(rest)

        expect(command.call).to eq([expected_2fa])
      end
    end
  end
end
