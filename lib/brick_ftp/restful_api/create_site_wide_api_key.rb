# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create site-wide API Key
    #
    # @see https://developers.files.com/#create-site-wide-api-key Create site-wide API Key
    #
    # ### Params
    #
    # PARAMETER      | TYPE     | DESCRIPTION
    # -------------- | -------- | -----------
    # name           | string   | Required: Public name for this API key.
    # permission_set | string   | Leave blank, or set to desktop_app to restrict the key to only desktop app functions.
    # expires_at     | string   | Have the key expire at this date/time.
    #
    class CreateSiteWideApiKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateUserApiKeyParams',
        :name,
        :permission_set,
        :expires_at,
        keyword_init: true
      )

      # Create site-wide API Key
      #
      # @param [BrickFTP::RESTfulAPI::CreateSiteWideApiKey::Params] params parameters for creating an API key
      # @return [BrickFTP::Types::ApiKey]
      #
      def call(params)
        res = client.post('/api/rest/v1/site/api_keys.json', params.to_h.compact)

        BrickFTP::Types::ApiKey.new(res.symbolize_keys)
      end
    end
  end
end
