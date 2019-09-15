# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete API Key
    #
    # @see https://developers.files.com/#delete-api-key Delete API Key
    #
    class DeleteApiKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | Required: API Key ID.
      Params = Struct.new(
        'DeleteApiKeyParams',
        :id,
        keyword_init: true
      )

      # Delete API Key
      #
      # @param [BrickFTP::RESTfulAPI::DeleteApiKey::Params] params parameters
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        client.delete("/api/rest/v1/api_keys/#{params[:id]}.json")
        true
      end
    end
  end
end
