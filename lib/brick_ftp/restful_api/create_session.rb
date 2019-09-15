# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create user session (log in)
    #
    # @see https://developers.files.com/#create-user-session-log-in Create user session (log in)
    #
    class CreateSession
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE   | DESCRIPTION
      # --------- | ------ | -----------
      # username  | string | Username to sign in as
      # password  | string | Password for sign in
      # otp       | string | If this user has a 2FA device, provide its OTP or code here.
      Params = Struct.new(
        'CreateSessionParams',
        :username,
        :password,
        :otp,
        keyword_init: true
      )

      # Creates user session.
      #
      # @param [BrickFTP::RESTfulAPI::CreateSession::Params] params parameters
      # @return [BrickFTP::Types::Session]
      #
      def call(params = {})
        res = client.post('/api/rest/v1/sessions.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::Session.new(res.symbolize_keys)
      end
    end
  end
end
