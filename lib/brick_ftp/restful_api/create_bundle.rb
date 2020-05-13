# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create a bundle
    #
    # @see https://developers.files.com/#create-a-bundle Create a bundle
    #
    # ### Params
    #
    # PARAMETER | TYPE   | DESCRIPTION
    # --------- | ------ | -----------
    # paths     | array  | List of the paths associated with the bundle.
    # password  | string | Optional password to password-protect the bundle. This property is write-only. It cannot be retrieved via the API.
    #
    class CreateBundle
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateBundleParams',
        :paths,
        :password,
        keyword_init: true
      )

      # Creates a new group on the current site.
      #
      # @param [BrickFTP::RESTfulAPI::CreateBundle::Params] params parameters
      # @return [BrickFTP::Types::Bundle] Bundle
      #
      def call(params)
        res = client.post('/api/rest/v1/bundles.json', params.to_h.compact)

        BrickFTP::Types::Bundle.new(**res.symbolize_keys)
      end
    end
  end
end
