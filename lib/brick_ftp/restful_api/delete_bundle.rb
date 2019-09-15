# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete bundle
    #
    # @see https://developers.files.com/#delete-bundle Delete bundle
    #
    class DeleteBundle
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | Required: Bundle ID.
      Params = Struct.new(
        'DeleteBundleParams',
        :id,
        keyword_init: true
      )

      # Delete bundle
      #
      # @param [BrickFTP::RESTfulAPI::DeleteBundle::Params] params parameters
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        client.delete("/api/rest/v1/bundles/#{params.delete(:id)}.json")
        true
      end
    end
  end
end
