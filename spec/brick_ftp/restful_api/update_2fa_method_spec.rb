# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::Update2faMethod, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return updated TwoFactorAuthenticationMethod object' do
        updated_2fa_method = BrickFTP::Types::TwoFactorAuthenticationMethod.new(
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

        stub_request(:patch, 'https://subdomain.files.com/api/rest/v1/2fa/1.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              otp: '123456',
              name: 'My Verizon Phone',
            }.to_json
          )
          .to_return(body: updated_2fa_method.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::Update2faMethod::Params.new(
          id: 1,
          otp: '123456',
          name: 'My Verizon Phone'
        )
        command = BrickFTP::RESTfulAPI::Update2faMethod.new(rest)

        expect(command.call(params)).to eq updated_2fa_method
      end
    end
  end
end
