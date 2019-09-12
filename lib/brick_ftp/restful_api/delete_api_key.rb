# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete API Key
    #
    # @see https://developers.files.com/#delete-api-key Delete API Key
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: API Key ID.
    #
    class DeleteAPIKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'DeleteAPIKeyParams',
        :id,
        keyword_init: true
      )

      # Delete API Key
      #
      # @param [BrickFTP::RESTfulAPI::DeleteAPIKey::Params] params parameters
      #
      def call(params)
        params = params.to_h.compact
        client.delete("/api/rest/v1/api_keys/#{params[:id]}.json")
        true
      end
    end
  end
end
