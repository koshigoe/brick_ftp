# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class ListBehaviors
      include Command

      # Returns a list of all behaviors on the current site.
      #
      # @return [Array<BrickFTP::Types::Behavior>] Behaviors
      #
      def call
        res = client.get('/api/rest/v1/behaviors.json')

        res.map { |i| BrickFTP::Types::Behavior.new(i.symbolize_keys) }
      end
    end
  end
end