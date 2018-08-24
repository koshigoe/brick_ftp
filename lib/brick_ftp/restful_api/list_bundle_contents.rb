# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List bundle contents
    #
    # @see https://developers.brickftp.com/#list-bundle-contents List bundle contents
    #
    # ### Params
    #
    # PARAMETER | TYPE   | DESCRIPTION
    # --------- | ------ | -----------
    # code      | string | Unique code string identifier for the bundle.
    # password  | string | Optional password to password-protect the bundle. This property is write-only. It cannot be retrieved via the API.
    #
    class ListBundleContents
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'ListBundleContentsParams',
        :code,
        :password,
        keyword_init: true
      )

      # This unauthenticated (public) endpoint lists the contents of a bundle.
      #
      # When no path is specified, the contents of the root of the bundle will be listed. The contents of a subfolder
      # can be listed by providing its path in the URL after /contents, for example: /bundles/contents/cloud/images.
      # Alternatively, you can provide path as a parameter in the request body instead of in the URL.
      #
      # This endpoint only reveals the public part of the file paths (i.e. relative to the root of the bundle).
      # To view the full path of included files, use the authenticated Show Bundle endpoint above.
      #
      # The password parameter is required only for bundles that are password-protected. If a bundle is password-protected
      # and the password is missing or incorrect, an error message will specify that the correct password is required.
      #
      # @param [String, nil] path
      # @param [BrickFTP::RESTfulAPI::ListBundleContents::Params] params parameters
      # @return [Array<BrickFTP::Types::BundleContent>] BundleContent
      #
      def call(params, path: nil)
        endpoint = if path
                     "/api/rest/v1/bundles/contents/#{ERB::Util.url_encode(path)}"
                   else
                     '/api/rest/v1/bundles/contents.json'
                   end
        res = client.post(endpoint, params.to_h.compact)

        res.map { |i| BrickFTP::Types::BundleContent.new(i.symbolize_keys) }
      end
    end
  end
end
