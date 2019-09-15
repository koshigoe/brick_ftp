# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update behavior
    #
    # @see https://developers.files.com/#update-behavior Update behavior
    #
    class UpdateBehavior
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | Required: Folder behavior ID.
      # value     | integer | The value of the folder behavior. Can be a integer, array, or hash depending on the type of folder behavior.
      Params = Struct.new(
        'UpdateBehaviorParams',
        :id,
        :value,
        keyword_init: true
      )

      # Update behavior
      #
      # @param [BrickFTP::RESTfulAPI::UpdateBehavior::Params] params parameters
      # @return [BrickFTP::Types::Behavior] Behavior
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.patch("/api/rest/v1/behaviors/#{params.delete(:id)}.json", params)

        BrickFTP::Types::Behavior.new(res.symbolize_keys)
      end
    end
  end
end
