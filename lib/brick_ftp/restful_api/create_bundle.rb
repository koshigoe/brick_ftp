# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create bundle
    #
    # @see https://developers.files.com/#create-bundle Create bundle
    #
    # ### Params
    #
    # PARAMETER   | TYPE          | DESCRIPTION
    # ----------- | ------------- | -----------
    # paths       | array(string) | Required: A list of paths to include in this bundle.
    # password    | string        | Password for this bundle.
    # expires_at  | string        | Bundle expiration date/time.
    # description | string        | Bundle public description
    # note        | string        | Bundle internal note
    #
    class CreateBundle
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateBundleParams',
        :paths,
        :password,
        :expires_at,
        :description,
        :note,
        keyword_init: true
      )

      # Create bundle
      #
      # @param [BrickFTP::RESTfulAPI::CreateBundle::Params] params parameters
      # @return [BrickFTP::Types::Bundle]
      #
      def call(params)
        res = client.post('/api/rest/v1/bundles.json', params.to_h.compact)

        BrickFTP::Types::Bundle.new(res.symbolize_keys)
      end
    end
  end
end
