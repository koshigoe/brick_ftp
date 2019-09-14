# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List locks at path
    #
    # @see https://developers.files.com/#list-locks-at-path List locks at path
    #
    # ### Params
    #
    # PARAMETER | TYPE     | DESCRIPTION
    # --------- | -------- | -----------
    # path      | string   | Required
    #
    class ListLocks
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'ListLocksParams',
        :path,
        keyword_init: true
      )

      # List locks at path
      #
      # @param [BrickFTP::RESTfulAPI::ListLocks::Params] params parameters
      # @return [Array<BrickFTP::Types::Lock>]
      #
      def call(params)
        params = Params.new(params.to_h).to_h.compact
        path = params.delete(:path)
        res = client.get("/api/rest/v1/locks/#{ERB::Util.url_encode(path)}")

        res.map { |i| BrickFTP::Types::Lock.new(i.symbolize_keys) }
      end
    end
  end
end
