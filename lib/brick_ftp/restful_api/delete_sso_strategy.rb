# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete SSO strategy
    #
    # @see https://developers.files.com/#delete-sso-strategy Delete SSO strategy
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer |
    #
    class DeleteSsoStrategy
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'DeleteSsoStrategyParams',
        :id,
        keyword_init: true
      )

      # Delete SSO strategy
      #
      # @param [BrickFTP::RESTfulAPI::DeleteSsoStrategy::Params] params parameters
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        client.delete("/api/rest/v1/sso_strategies/#{params[:id]}.json")
        true
      end
    end
  end
end
