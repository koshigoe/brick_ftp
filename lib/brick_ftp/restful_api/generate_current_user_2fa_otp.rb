# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Generate (and send if applicable) a one time password for current user's primary 2FA method
    #
    # @see https://developers.files.com/#generate-and-send-if-applicable-a-one-time-password-for-current-user-39-s-primary-2fa-method Generate (and send if applicable) a one time password for current user's primary 2FA method
    #
    class GenerateCurrentUser2faOtp
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # u2f_only  | boolean | Set to true to only generate an OTP for U2F (FIDO) keys and skip things like SMS.
      Params = Struct.new(
        'GenerateCurrentUser2faOtpParams',
        :u2f_only,
        keyword_init: true
      )

      # Generate (and send if applicable) a one time password for current user's primary 2FA method
      #
      # @param [BrickFTP::RESTfulAPI::GenerateCurrentUser2faOtp::Params] params parameters
      # @return [BrickFTP::Types::TwoFactorAuthenticationOtp]
      #
      def call(params = {})
        res = client.post('/api/rest/v1/2fa/send_code.json', Params.new(params.to_h).to_h.compact)

        res.map { |i| BrickFTP::Types::TwoFactorAuthenticationOtp.new(i.symbolize_keys) }
      end
    end
  end
end
