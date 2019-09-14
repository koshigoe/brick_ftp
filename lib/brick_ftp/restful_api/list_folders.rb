# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List folder
    #
    # @see https://developers.files.com/#list-folder List folder
    #
    # ### Params
    #
    # PARAMETER           | TYPE    | DESCRIPTION
    # ------------------- | ------- | -----------
    # path                | string  | Required: Folder path.
    # action              | string  | Action to take. Can be `count`, `count_nrs` (non recursive), `size`, `permissions`, or blank.
    # filter              | string  | Specify to filter folders/files list by name.
    # page                | integer | Current page in folders/files list.
    # per_page            | integer | Number of folders/files to show per page.
    # preview_size        | string  | Request a preview size. Can be `small` (default), `large`, `xlarge`, or `pdf`.
    # search_all          | boolean | Search entire site?
    # with_preview        | boolean | Include file preview information?
    # with_priority_color | boolean | Include file priority color information?
    #
    class ListFolders
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'ListFoldersParams',
        :path,
        :action,
        :filter,
        :page,
        :per_page,
        :preview_size,
        :search_all,
        :with_preview,
        :with_priority_color,
        keyword_init: true
      )

      # List folder
      #
      # @param [BrickFTP::RESTfulAPI::ListFolders::Params] params parameters
      # @return [Array<BrickFTP::Types::File>] Files
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        path = params.delete(:path)

        query = params.sort.map { |k, v| "#{k}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
        endpoint = "/api/rest/v1/folders/#{ERB::Util.url_encode(path)}"
        endpoint += "?#{query}" unless query.empty?

        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::File.new(i.symbolize_keys) }
      end
    end
  end
end
