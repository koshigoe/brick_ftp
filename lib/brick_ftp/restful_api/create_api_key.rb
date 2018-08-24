# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create an API key
    #
    # @see https://developers.brickftp.com/#create-an-api-key Create an API key
    #
    # ### Params
    #
    # PARAMETER      | TYPE     | DESCRIPTION
    # -------------- | -------- | -----------
    # name           | string   | Name to identify the user API key. For your reference. Maximum of 100 characters.
    # permission_set | string   | The permission set for the user API key. Can be desktop_app or full.
    # platform       | string   | The platform for the user API key. Can be win32, macos, linux, or none. Applies only to API keys with a permission_set of desktop_app.
    # expires_at     | datetime | The date that this API key is valid through.
    #
    class CreateAPIKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateAPIKeyParams',
        :name,
        :permission_set,
        :platform,
        :expires_at,
        keyword_init: true
      )

      # Creates a new API key for a user on the current site.
      #
      # @param [Integer] id Globally unique identifier of each user.
      #   Each user is given an ID automatically upon creation.
      # @param [BrickFTP::RESTfulAPI::CreateAPIKey::Params] params parameters for creating an API key
      # @return [BrickFTP::Types::UserAPIKey] User's API key
      #
      def call(id, params)
        res = client.post("/api/rest/v1/users/#{id}/api_keys.json", params.to_h.compact)

        BrickFTP::Types::UserAPIKey.new(res.symbolize_keys)
      end
    end
  end
end
