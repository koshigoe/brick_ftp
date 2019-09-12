# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create API Key for current user
    #
    # @see https://developers.files.com/#create-api-key-for-current-user Create API Key for current user
    #
    # ### Params
    #
    # PARAMETER      | TYPE     | DESCRIPTION
    # -------------- | -------- | -----------
    # name           | string   | Required: Internal name for key. For your reference only.
    # permission_set | string   | Leave blank, or set to desktop_app to restrict the key to only desktop app functions.
    # expires_at     | string   | Have the key expire at this date/time.
    #
    class CreateCurrentUserApiKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateCurrentUserApiKeyParams',
        :name,
        :permission_set,
        :expires_at,
        keyword_init: true
      )

      # Create API Key for current user
      #
      # @param [BrickFTP::RESTfulAPI::CreateCurrentUserApiKey::Params] params parameters for creating an API key
      # @return [BrickFTP::Types::UserApiKey]
      #
      def call(params)
        res = client.post('/api/rest/v1/user/api_keys.json', params.to_h.compact)

        BrickFTP::Types::ApiKey.new(res.symbolize_keys)
      end
    end
  end
end
