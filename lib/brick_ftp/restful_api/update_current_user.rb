# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update current user
    #
    # @see https://developers.files.com/#update-current-user Update current user
    #
    class UpdateCurrentUser
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER                    | TYPE    | DESCRIPTION
      # ---------------------------- | ------- | -----------
      # change_password              | string  | New password
      # change_password_confirmation | string  | Confirm new password (optional, but if provided it will be validated against the value in change_password)
      # email                        | string  | User's email address
      # time_zone                    | string  | User's time zone
      # language                     | string  | User's language (2 digit ISO code, lowercase)
      # skip_welcome_screen          | boolean | Hide the welcome screen in web UI?
      # announcements_read           | boolean | Has this user read the latest announcements?
      Params = Struct.new(
        'UpdateCurrentUserParams',
        :change_password,
        :change_password_confirmation,
        :email,
        :time_zone,
        :language,
        :skip_welcome_screen,
        :announcements_read,
        keyword_init: true
      )

      # Update current user
      #
      # @param [BrickFTP::RESTfulAPI::UpdateCurrentUser::Params] params parameters
      # @return [BrickFTP::Types::User]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.patch('/api/rest/v1/user.json', params)

        BrickFTP::Types::User.new(res.symbolize_keys)
      end
    end
  end
end
