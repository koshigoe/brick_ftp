# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List user's API keys
    #
    # @see https://developers.files.com/#list-current-user-39-s-api-keys List user's API keys
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: User ID.
    #
    class ListUserAPIKeys
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'ListCurrentUserApiKeys',
        :id,
        keyword_init: true
      )

      # List user's API keys
      #
      # @param [BrickFTP::RESTfulAPI::ListUserApiKeys::Params] params parameters
      # @return [Array<BrickFTP::Types::APIKey>]
      #
      def call(params)
        params = params.to_h.compact
        res = client.get("/api/rest/v1/users/#{params[:id]}/api_keys.json")

        res.map { |i| BrickFTP::Types::APIKey.new(i.symbolize_keys) }
      end
    end
  end
end
