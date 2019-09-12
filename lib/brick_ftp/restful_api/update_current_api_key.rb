# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update current API key. (Requires current API connection to be using an API key.)
    #
    # @see https://developers.files.com/#update-current-api-key-requires-current-api-connection-to-be-using-an-api-key Update current API key. (Requires current API connection to be using an API key.)
    #
    # ### Params
    #
    # PARAMETER      | TYPE   | DESCRIPTION
    # -------------- | ------ | -----------
    # name           | string | Internal name for key. For your reference only.
    # permission_set | string | Leave blank, or set to desktop_app to restrict the key to only desktop app functions.
    # expires_at     | string | Have the key expire at this date/time.
    #
    class UpdateCurrentAPIKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'UpdateCurrentAPIKeyParams',
        :name,
        :permission_set,
        :expires_at,
        keyword_init: true
      )

      # Update current API key. (Requires current API connection to be using an API key.)
      #
      # @param [BrickFTP::RESTfulAPI::UpdateCurrentAPIKey::Params] params parameters for update API key
      # @return [BrickFTP::Types::APIKey]
      #
      def call(params)
        res = client.patch('/api/rest/v1/api_key.json', params.to_h.compact)

        BrickFTP::Types::APIKey.new(res.symbolize_keys)
      end
    end
  end
end
