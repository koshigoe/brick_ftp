# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class GetFileInBundle
      include Command

      # rubocop:disable Metrics/LineLength
      Params = Struct.new(
        'GetFileInBundleParams',
        :code,     # string | Unique code string identifier for the bundle.
        :path,     # string |
        :password, # string | Optional password to password-protect the bundle. This property is write-only. It cannot be retrieved via the API.
        keyword_init: true
      )
      # rubocop:enable Metrics/LineLength

      # Provides a download URL to download a single file in the bundle.
      #
      # The download URL is a direct URL to Amazon S3 that has been signed by BrickFTP to provide temporary access to the file.
      # The download links are valid for 3 minutes. For details on the attributes in the response body from this endpoint, please see The file object.
      #
      # The password parameter is required only for bundles that are password-protected.
      # If a bundle is password-protected and the password is missing or incorrect, an error message will specify that the correct password is required.
      #
      # @param [BrickFTP::RESTfulAPI::GetFileInBundle::Params] params parameters
      # @return [BrickFTP::Types::FileInBundle] FileInBundle
      #
      def call(params)
        res = client.post('/api/rest/v1/bundles/download.json', params.to_h.compact)

        BrickFTP::Types::FileInBundle.new(res.symbolize_keys)
      end
    end
  end
end
