# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Delete 2FA method
    #
    # @see https://developers.files.com/#delete-2fa-method Delete 2FA method
    #
    class Delete2faMethod
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | Required: 2FA Method ID.
      Params = Struct.new(
        'Delete2faMethodParams',
        :id,
        keyword_init: true
      )

      # Delete 2FA method
      #
      # @param [BrickFTP::RESTfulAPI::Delete2faMethod::Params] params parameters
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        client.delete("/api/rest/v1/2fa/#{params.delete(:id)}.json")
        true
      end
    end
  end
end
