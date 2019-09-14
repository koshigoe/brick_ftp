# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Download entire bundle as ZIP
    #
    # @see https://developers.files.com/#download-entire-bundle-as-zip Download entire bundle as ZIP
    #
    # ### Params
    #
    # PARAMETER | TYPE   | DESCRIPTION
    # --------- | ------ | -----------
    # code,     | string | Unique code string identifier for the bundle.
    # password  | string | Optional password to password-protect the bundle. This property is write-only. It cannot be retrieved via the API.
    #
    class GetBundleZip
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'GetBundleZipParams',
        :code,
        :password,
        keyword_init: true
      )

      # Provides a download URL that will enable you to download all the files in a bundle as a single ZIP.
      #
      # The download URLs can be downloaded using an HTTP GET to the same hostname providing the download_uri
      # as the URL path. This will be routed by our frontend proxies to our ZIP server that will stream the ZIP.
      # The ZIP download link is valid for 3 minutes.
      #
      # The password parameter is required only for bundles that are password-protected.
      # If a bundle is password-protected and the password is missing or incorrect, an error message will
      # specify that the correct password is required.
      #
      # @param [BrickFTP::RESTfulAPI::GetFileInBundle::Params] params parameters
      # @return [BrickFTP::Types::BundleZip] BundleZip
      #
      def call(params)
        res = client.post('/api/rest/v1/bundles/zip.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::BundleZip.new(res.symbolize_keys)
      end
    end
  end
end
