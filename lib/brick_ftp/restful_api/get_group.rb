# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show group
    #
    # @see https://developers.files.com/#show-group Show group
    #
    class GetGroup
      include Command
      using BrickFTP::CoreExt::Hash

      # Show group
      #
      # @param [Integer] id Group ID.
      # @return [BrickFTP::Types::Group, nil]
      #
      def call(id)
        res = client.get("/api/rest/v1/groups/#{id}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::Group.new(res.symbolize_keys)
      end
    end
  end
end
