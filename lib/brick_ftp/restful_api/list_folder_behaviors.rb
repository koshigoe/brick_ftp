# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List behaviors by path
    #
    # @see https://developers.files.com/#list-behaviors-by-path List behaviors by path
    #
    # ### Params
    #
    # PARAMETER | TYPE     | DESCRIPTION
    # --------- | -------- | -----------
    # path      | string   | Required: Folder behaviors path.
    # recursive | string   | Show behaviors below this path?
    # behavior  | string   | If set only shows folder behaviors matching this behavior type.
    #
    class ListFolderBehaviors
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'ListFolderBehaviorsParams',
        :behavior,
        :recursive,
        keyword_init: true
      )

      # List behaviors by path
      #
      # @param [String] path Folder behaviors path.
      # @param [BrickFTP::RESTfulAPI::ListFolderBehaviors::Params] params parameters for search folder behaviors
      # @return [Array<BrickFTP::Types::Behavior>] Behaviors
      #
      def call(path, params)
        endpoint = "/api/rest/v1/behaviors/folders/#{ERB::Util.url_encode(path)}"
        query = params.to_h.compact.sort.map { |k, v| "#{k}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
        endpoint += "?#{query}" unless query.empty?
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::Behavior.new(i.symbolize_keys) }
      end
    end
  end
end
