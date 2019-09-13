# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Delete lock
    #
    # @see https://developers.files.com/#delete-lock Delete lock
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # path      | string  | Required: Path
    # token     | string  | Required: Lock token
    #
    class DeleteLock
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'DeleteLock',
        :path,
        :token,
        keyword_init: true
      )

      # Delete lock
      #
      # @param [BrickFTP::RESTfulAPI::DeleteLock::Params] params parameters
      #
      def call(params)
        params = params.to_h.compact
        path = params.delete(:path)
        client.delete("/api/rest/v1/locks/#{ERB::Util.url_encode(path)}", params)
        true
      end
    end
  end
end
