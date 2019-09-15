# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update current API key. (Requires current API connection to be using an API key.)
    #
    # @see https://developers.files.com/#update-current-api-key-requires-current-api-connection-to-be-using-an-api-key Update current API key. (Requires current API connection to be using an API key.)
    #
    class UpdateCurrentApiKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER      | TYPE   | DESCRIPTION
      # -------------- | ------ | -----------
      # name           | string | Internal name for key. For your reference only.
      # permission_set | string | Leave blank, or set to desktop_app to restrict the key to only desktop app functions.
      # expires_at     | string | Have the key expire at this date/time.
      Params = Struct.new(
        'UpdateCurrentApiKeyParams',
        :name,
        :permission_set,
        :expires_at,
        keyword_init: true
      )

      # Update current API key. (Requires current API connection to be using an API key.)
      #
      # @param [BrickFTP::RESTfulAPI::UpdateCurrentApiKey::Params] params parameters
      # @return [BrickFTP::Types::ApiKey]
      #
      def call(params = {})
        res = client.patch('/api/rest/v1/api_key.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::ApiKey.new(res.symbolize_keys)
      end
    end
  end
end
