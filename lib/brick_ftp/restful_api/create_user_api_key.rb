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
    class CreateUserApiKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateUserApiKeyParams',
        :id,
        :name,
        :permission_set,
        :expires_at,
        keyword_init: true
      )

      # Create API key for user
      #
      # @param [BrickFTP::RESTfulAPI::CreateUserApiKey::Params] params parameters
      # @return [BrickFTP::Types::ApiKey]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.post("/api/rest/v1/users/#{params.delete(:id)}/api_keys.json", params)

        BrickFTP::Types::ApiKey.new(res.symbolize_keys)
      end
    end
  end
end
