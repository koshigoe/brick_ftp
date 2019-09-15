# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List behaviors by path
    #
    # @see https://developers.files.com/#list-behaviors-by-path List behaviors by path
    #
    class ListFolderBehaviors
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE     | DESCRIPTION
      # --------- | -------- | -----------
      # path      | string   | Required: Folder behaviors path.
      # recursive | string   | Show behaviors below this path?
      # behavior  | string   | If set only shows folder behaviors matching this behavior type.
      Params = Struct.new(
        'ListFolderBehaviorsParams',
        :path,
        :behavior,
        :recursive,
        keyword_init: true
      )

      # List behaviors by path
      #
      # @param [BrickFTP::RESTfulAPI::ListFolderBehaviors::Params] params parameters
      # @return [Array<BrickFTP::Types::Behavior>] Behaviors
      #
      def call(params)
        params = Params.new(params.to_h).to_h.compact
        path = params.delete(:path)
        query = params.sort.map { |k, v| "#{k}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
        endpoint = "/api/rest/v1/behaviors/folders/#{ERB::Util.url_encode(path)}"
        endpoint += "?#{query}" unless query.empty?
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::Behavior.new(i.symbolize_keys) }
      end
    end
  end
end
