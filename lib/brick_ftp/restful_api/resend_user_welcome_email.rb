# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Resend user welcome email
    #
    # @see https://developers.files.com/#resend-user-welcome-email Resend user welcome email
    #
    class ResendUserWelcomeEmail
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | Required: User ID.
      Params = Struct.new(
        'ResendUserWelcomeEmailParams',
        :id,
        keyword_init: true
      )

      # Resend user welcome email
      #
      # @param [BrickFTP::RESTfulAPI::ResendUserWelcomeEmail::Params] params parameters
      # @return [BrickFTP::Types::User]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.post("/api/rest/v1/users/#{params.delete(:id)}/resend_welcome_email.json")

        BrickFTP::Types::User.new(res.symbolize_keys)
      end
    end
  end
end
