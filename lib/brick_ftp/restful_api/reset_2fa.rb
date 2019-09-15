# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
    #
    # @see https://developers.files.com/#trigger-2fa-reset-process-for-user-who-has-lost-access-to-their-existing-2fa-methods Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
    #
    class Reset2fa
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | 2FA Method ID.
      Params = Struct.new(
        'Reset2faParams',
        :id,
        keyword_init: true
      )

      # Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
      #
      # @param [BrickFTP::RESTfulAPI::Reset2fa::Params] params parameters
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        client.post("/api/rest/v1/users/#{params.delete(:id)}/2fa/reset.json")
        true
      end
    end
  end
end
