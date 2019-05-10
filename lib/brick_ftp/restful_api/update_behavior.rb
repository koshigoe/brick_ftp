# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update a behavior
    #
    # @see https://developers.files.com/#update-a-behavior Update a behavior
    #
    # ### Params
    #
    # PARAMETER | TYPE   | DESCRIPTION
    # --------- | ------ | -----------
    # value     | array | Array of values associated with the behavior.
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

      # Updates an existing behavior.
      #
      # @param [Integer] id Globally unique identifier of each behavior.
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
