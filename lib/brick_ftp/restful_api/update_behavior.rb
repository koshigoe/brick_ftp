# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update behavior
    #
    # @see https://developers.files.com/#update-behavior Update behavior
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: Folder behavior ID.
    # value     | integer | The value of the folder behavior. Can be a integer, array, or hash depending on the type of folder behavior.
    #
    class UpdateBehavior
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'UpdateBehaviorParams',
        :value,
        keyword_init: true
      )

      # Update behavior
      #
      # @param [Integer] id Folder behavior ID.
      # @param [BrickFTP::RESTfulAPI::UpdateBehavior::Params] params parameters
      # @return [BrickFTP::Types::Behavior] Behavior
      #
      def call(id, params)
        res = client.patch("/api/rest/v1/behaviors/#{id}.json", params.to_h.compact)

        BrickFTP::Types::Behavior.new(res.symbolize_keys)
      end
    end
  end
end
