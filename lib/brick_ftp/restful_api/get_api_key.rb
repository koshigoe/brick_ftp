# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show API Key
    #
    # @see https://developers.files.com/#show-api-key Show API Key
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: API Key ID.
    #
    class GetAPIKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'GetApiKeyParams',
        :id,
        keyword_init: true
      )

      # Show API Key
      #
      # @param [BrickFTP::RESTfulAPI::GetApiKey::Params] params parameters
      # @return [BrickFTP::Types::APIKey]
      #
      def call(params)
        params = params.to_h.compact
        res = client.get("/api/rest/v1/api_keys/#{params[:id]}.json")

        BrickFTP::Types::APIKey.new(res.symbolize_keys)
      end
    end
  end
end
