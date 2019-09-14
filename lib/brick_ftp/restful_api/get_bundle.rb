# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show bundle
    #
    # @see https://developers.files.com/#show-bundle Show bundle
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: Bundle ID.
    #
    class GetBundle
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'GetBundleParams',
        :id,
        keyword_init: true
      )

      # Show bundle
      #
      # @param [BrickFTP::RESTfulAPI::GetBundle::Params] params parameters
      # @return [BrickFTP::Types::Bundle] Bundle
      #
      def call(params)
        params = params.to_h.compact
        res = client.get("/api/rest/v1/bundles/#{params.delete(:id)}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::Bundle.new(res.symbolize_keys)
      end
    end
  end
end
