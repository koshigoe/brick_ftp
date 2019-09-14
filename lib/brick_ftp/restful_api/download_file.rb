# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Download file
    #
    # @see https://developers.files.com/#download-file Download file
    #
    # ### Params
    #
    # PARAMETER           | TYPE     | DESCRIPTION
    # ------------------- | -------- | -----------
    # action              | string   | Can be blank, redirect or stat.
    # path                | string   | Required: File path.
    # with_previews       | boolean  | Include file preview information?
    # with_priority_color | boolean  | Include file priority color information?
    #
    class DownloadFile
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'DownloadFileParams',
        :action,
        :path,
        :with_previews,
        :with_priority_color,
        keyword_init: true
      )

      # Download file
      #
      # @param [BrickFTP::RESTfulAPI::DownloadFile::Params] params parameters
      # @return [BrickFTP::Types::File]
      #
      def call(params)
        params = params.to_h.compact
        path = params.delete(:path)
        endpoint = "/api/rest/v1/files/#{ERB::Util.url_encode(path)}"
        query = params.to_h.compact.map { |k, v| "#{k}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
        endpoint += "?#{query}" unless query.empty?
        res = client.get(endpoint)
        return nil if !res || res.empty?

        BrickFTP::Types::File.new(res.symbolize_keys)
      end
    end
  end
end
