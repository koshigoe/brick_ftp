# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Unlock user who has been locked out due to failed logins
    #
    # @see https://developers.files.com/#unlock-user-who-has-been-locked-out-due-to-failed-logins Unlock user who has been locked out due to failed logins
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: User ID.
    #
    class UnlockUser
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'UnlockUserParams',
        :id,
        keyword_init: true
      )

      # Unlock user who has been locked out due to failed logins
      #
      # @param [BrickFTP::RESTfulAPI::UnlockUser::Params] params parameters
      # @return [BrickFTP::Types::User, nil]
      #
      def call(params)
        params = params.to_h.compact
        res = client.post("/api/rest/v1/users/#{params.delete(:id)}/unlock.json")

        BrickFTP::Types::User.new(res.symbolize_keys)
      end
    end
  end
end
