# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create API key for user
    #
    # @see https://developers.files.com/#create-api-key-for-user Create API key for user
    #
    # ### Params
    #
    # PARAMETER      | TYPE     | DESCRIPTION
    # -------------- | -------- | -----------
    # id             | integer  | Required: User ID.
    # name           | string   | Required: Public name for this API key.
    # permission_set | string   | Leave blank, or set to desktop_app to restrict the key to only desktop app functions.
    # expires_at     | string   | Have the key expire at this date/time.
    #
    class CreateUserAPIKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateUserAPIKeyParams',
        :id,
        :name,
        :permission_set,
        :expires_at,
        keyword_init: true
      )

      # Create API key for user
      #
      # @param [BrickFTP::RESTfulAPI::CreateUserAPIKey::Params] params parameters for creating an API key
      # @return [BrickFTP::Types::APIKey]
      #
      def call(params)
        params = params.to_h.compact
        res = client.post("/api/rest/v1/users/#{params.delete(:id)}/api_keys.json", params)

        BrickFTP::Types::APIKey.new(res.symbolize_keys)
      end
    end
  end
end
