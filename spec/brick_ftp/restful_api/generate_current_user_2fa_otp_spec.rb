# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GenerateCurrentUser2faOtp, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return generated TwoFactorAuthenticationOtp object' do
        created_2fa_otp = BrickFTP::Types::TwoFactorAuthenticationOtp.new(
          app_id: '[app id]',
          challenge: '[challenge]',
          sign_request: '[sign request]'
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/2fa/send_code.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { u2f_only: true }.to_json
          )
          .to_return(body: [created_2fa_otp.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::GenerateCurrentUser2faOtp::Params.new(u2f_only: true)
        command = BrickFTP::RESTfulAPI::GenerateCurrentUser2faOtp.new(rest)

        expect(command.call(params)).to eq [created_2fa_otp]
      end
    end
  end
end
