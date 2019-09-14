# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete group
    #
    # @see https://developers.files.com/#delete-group Delete group
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: Group ID.
    #
    class DeleteGroup
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'DeleteGroupParams',
        :id,
        keyword_init: true
      )

      # Delete group
      #
      # @param [BrickFTP::RESTfulAPI::DeleteGroup::Params] params parameters
      #
      def call(params)
        params = params.to_h.compact
        client.delete("/api/rest/v1/groups/#{params.delete(:id)}.json")
        true
      end
    end
  end
end
