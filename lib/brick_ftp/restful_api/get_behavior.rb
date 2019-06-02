# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show a behavior
    #
    # @see https://developers.files.com/#show-a-behavior Show a behavior
    #
    class GetBehavior
      include Command
      using BrickFTP::CoreExt::Hash

      # Returns a single behavior.
      #
      # @param [Integer] id Globally unique identifier of each behavior.
      # @return [BrickFTP::Types::Behavior, nil] found Behavior or nil
      #
      def call(id)
        res = client.get("/api/rest/v1/behaviors/#{id}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::Behavior.new(res.symbolize_keys)
      end
    end
  end
end
