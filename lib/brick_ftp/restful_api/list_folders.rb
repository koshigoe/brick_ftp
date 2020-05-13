# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List folder contents
    #
    # @see https://developers.files.com/#list-folder-contents List folder contents
    #
    # ### Params
    #
    # PARAMETER                     | TYPE     | DESCRIPTION
    # ----------------------------- | -------- | -----------
    # page                          | integer  | Page number of items to return in this request.
    # per_page                      | integer  | Requested number of items returned per request. Maximum: `5000`, leave blank for default (strongly recommended).
    # search                        | string   | Only return items matching the given search text.
    # sort_by[path]                 | enum     | Sort by file name, and value is either `asc` or `desc` to indicate normal or reverse sort. (Note that `sort_by[path] = asc` is the default.)
    # sort_by[size]                 | enum     | Sort by file size, and value is either `asc` or `desc` to indicate smaller files first or larger files first, respectively.
    # sort_by[modified_at_datetime] | enum     | Sort by modification time, and value is either `asc` or `desc` to indicate older files first or newer files first, respectively.
    #
    class ListFolders
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'ListFoldersParams',
        :page,
        :per_page,
        :search,
        :'sort_by[path]',
        :'sort_by[size]',
        :'sort_by[modified_at_datetime]',
        keyword_init: true
      )

      # Lists the contents of the folder provided in the URL.
      #
      # Remember that a blank URL refers to the root folder. So for example, you can list the contents of the root folder
      # using the REST API by sending a GET request to /folders. Another folder can be listed by inserting its complete
      # path in that URL after /folders, for example: /folders/employee/engineering.
      #
      # There is a maximum number of entries in the folder that will be listed with a single request
      # (default 1000 or whatever value you provide as the per_page parameter).
      # So if exactly that many entries are returned you will need to increment the value of the page parameter in
      # subsequent queries to continue listing the folder.
      #
      # @param [String] path Full path of the file or folder. Maximum of 550 characters.
      # @param [BrickFTP::RESTfulAPI::ListFolders::Params, nil] params parameters
      # @return [Array<BrickFTP::Types::File>] Files
      #
      def call(path, params = nil)
        validate_params!(params)

        query = build_query(params)
        endpoint = "/api/rest/v1/folders/#{ERB::Util.url_encode(path)}"
        endpoint = "#{endpoint}?#{query}" unless query.empty?

        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::File.new(**i.symbolize_keys) }
      end

      private

      def build_query(params)
        return '' if params.nil?

        params.to_h.compact.map { |k, v| "#{k}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
      end

      def validate_params!(params)
        return if params.nil?

        validate_page!(params[:page])
        validate_per_page!(params[:per_page])
        validate_sort_by!(params[:'sort_by[path]'])
        validate_sort_by!(params[:'sort_by[size]'])
        validate_sort_by!(params[:'sort_by[modified_at_datetime]'])
      end

      def validate_page!(page)
        return if page.nil?
        return if page.is_a?(Integer) && page.positive?

        raise ArgumentError, 'page must be greater than 0.'
      end

      MAX_PER_PAGE = 5_000

      def validate_per_page!(per_page)
        return if per_page.nil?
        return if per_page.is_a?(Integer) && per_page.positive? && per_page <= MAX_PER_PAGE

        raise ArgumentError, "per_page must be greater than 0 and less than equal #{MAX_PER_PAGE}."
      end

      VALID_SORT = %w[asc desc].freeze

      def validate_sort_by!(value)
        return if value.nil? || VALID_SORT.include?(value)

        raise ArgumentError, 'sort_by[*] must be `asc` or `desc`.'
      end
    end
  end
end
