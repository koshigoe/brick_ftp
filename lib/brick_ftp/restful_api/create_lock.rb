# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Create lock
    #
    # @see https://developers.files.com/#create-lock Create lock
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # path      | string  | Required: Path
    # timeout   | integer | Lock timeout length
    # scope     | string  | Lock scope(shared or exclusive)
    # type      | string  | Lock type
    #
    class CreateLock
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateLockParams',
        :path,
        :timeout,
        :scope,
        :type,
        keyword_init: true
      )

      # Create lock
      #
      # @param [BrickFTP::RESTfulAPI::CreateLock::Params] params parameters
      # @return [BrickFTP::Types::Lock]
      #
      def call(params)
        params = params.to_h.compact
        path = params.delete(:path)
        res = client.post("/api/rest/v1/locks/#{ERB::Util.url_encode(path)}", params)

        BrickFTP::Types::Lock.new(res.symbolize_keys)
      end
    end
  end
end
