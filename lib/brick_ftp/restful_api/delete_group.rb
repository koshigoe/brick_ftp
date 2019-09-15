# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete group
    #
    # @see https://developers.files.com/#delete-group Delete group
    #
    class DeleteGroup
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | Required: Group ID.
      Params = Struct.new(
        'DeleteGroupParams',
        :id,
        keyword_init: true
      )

      # Delete group
      #
      # @param [BrickFTP::RESTfulAPI::DeleteGroup::Params] params parameters
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        client.delete("/api/rest/v1/groups/#{params.delete(:id)}.json")
        true
      end
    end
  end
end
