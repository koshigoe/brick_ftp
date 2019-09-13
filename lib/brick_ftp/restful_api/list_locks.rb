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
      using BrickFTP::CoreExt::Hash

      # List locks at path
      #
      # @return [Array<BrickFTP::Types::Lock>]
      #
      def call(path)
        res = client.get("/api/rest/v1/locks/#{ERB::Util.url_encode(path)}")

        res.map { |i| BrickFTP::Types::Lock.new(i.symbolize_keys) }
      end
    end
  end
end
