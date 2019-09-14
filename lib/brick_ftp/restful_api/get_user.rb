# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show user
    #
    # @see https://developers.files.com/#show-user Show user
    #
    class GetUser
      include Command
      using BrickFTP::CoreExt::Hash

      # Show user
      #
      # @param [Integer] id User ID.
      # @return [BrickFTP::Types::User, nil]
      #
      def call(id)
        res = client.get("/api/rest/v1/users/#{id}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::User.new(res.symbolize_keys)
      end
    end
  end
end
