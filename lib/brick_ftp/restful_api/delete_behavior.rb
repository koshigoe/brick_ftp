# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete behavior
    #
    # @see https://developers.files.com/#delete-behavior Delete behavior
    #
    class DeleteBehavior
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | Required
      Params = Struct.new(
        'DeleteBehaviorParams',
        :id,
        keyword_init: true
      )

      # Delete behavior
      #
      # @param [BrickFTP::RESTfulAPI::DeleteBehavior::Params] params parameters
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        client.delete("/api/rest/v1/behaviors/#{params.delete(:id)}.json")
        true
      end
    end
  end
end
