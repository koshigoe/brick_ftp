# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create 2FA method on current user
    #
    # @see https://developers.files.com/#create-2fa-method-on-current-user Create 2FA method on current user
    #
    # ### Params
    #
    # PARAMETER    | TYPE    | DESCRIPTION
    # ------------ | ------- | -----------
    # method_type  | string  | Required: One of: `u2f`, `sms`, `totp`, `yubi`
    # name         | string  | Internal name, for reference only.
    # phone_number | string  | If method_type=sms, provide phone number.
    #
    class CreateCurrentUser2faMethod
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateCurrentUser2faMethodParams',
        :method_type,
        :name,
        :phone_number,
        keyword_init: true
      )

      # Create 2FA method on current user
      #
      # @param [BrickFTP::RESTfulAPI::CreateCurrentUser2faMethod::Params] params parameters
      # @return [BrickFTP::Types::TwoFactorAuthenticationMethod]
      #
      def call(params)
        res = client.post('/api/rest/v1/2fa.json', params.to_h.compact)

        BrickFTP::Types::TwoFactorAuthenticationMethod.new(res.symbolize_keys)
      end
    end
  end
end
