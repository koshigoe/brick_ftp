# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update 2FA method
    #
    # @see https://developers.files.com/#update-2fa-method Update 2FA method
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: 2FA Method ID.
    # otp       | string  | Current value of OTP, Yubikey string, or U2F response value. U2F response value requires a json stringified object containing fields clientData, keyHandle, and signatureData.
    # name      | string  | New name for 2FA method.
    #
    class Update2faMethod
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'Update2faMethodParams',
        :id,
        :otp,
        :name,
        keyword_init: true
      )

      # Update 2FA method
      #
      # @param [BrickFTP::RESTfulAPI::Update2faMethod::Params] params parameters
      # @return [BrickFTP::Types::TwoFactorAuthenticationMethod]
      #
      def call(params)
        params = Params.new(params.to_h).to_h.compact
        res = client.patch("/api/rest/v1/2fa/#{params.delete(:id)}.json", params)

        BrickFTP::Types::TwoFactorAuthenticationMethod.new(res.symbolize_keys)
      end
    end
  end
end
