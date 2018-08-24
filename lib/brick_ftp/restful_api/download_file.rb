# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Download a file
    #
    # @see https://developers.brickftp.com/#download-a-file Download a file
    #
    # ### Params
    #
    # PARAMETER | TYPE     | DESCRIPTION
    # --------- | -------- | -----------
    # action    | string   | Optionally set to `stat` to have the `download_uri` field omitted in the response and no download action logged.
    #
    class DownloadFile
      include Command

      # Provides a download URL that will enable you to download a file.
      #
      # The download URL is a direct URL to Amazon S3 that has been signed by BrickFTP to provide temporary
      # access to the file. The download links are valid for 3 minutes.
      #
      # By default this request assumes that the file will be downloaded, and therefore a download action is
      # logged for the user that is logged into the REST API session. If downloading the file is not desired,
      # but rather one is just looking at the information associated with the file such as the MD5 checksum or
      # file size, then the action query parameter can be passed in on the URL with the value of stat.
      # This causes the download_uri field to be omitted in the response and no download action to be logged.
      #
      # @param [String] path Full path of the file or folder. Maximum of 550 characters.
      # @param [Boolean] stat Optionally set to stat to have the `download_uri` field
      #   omitted in the response and no download action logged.
      # @return [BrickFTP::Types::File] File
      #
      def call(path, stat: false)
        endpoint = "/api/rest/v1/files/#{ERB::Util.url_encode(path)}"
        endpoint = "#{endpoint}?action=stat" if stat
        res = client.get(endpoint)
        return nil if !res || res.empty?

        BrickFTP::Types::File.new(res.symbolize_keys)
      end
    end
  end
end
