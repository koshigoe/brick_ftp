# frozen_string_literal: true

module BrickFTP
  module Commands
    class GetUser
      # @param [BrickFTP::REST] rest RESTful API client.
      def initialize(rest)
        @rest = rest
      end

      # Returns a single user.
      #
      # @param [Integer] id Globally unique identifier of each user.
      #   Each user is given an ID automatically upon creation.
      # @return [BrickFTP::Types::User, nil] found User or nil
      #
      def call(id:)
        res = @rest.get("/api/rest/v1/users/#{id}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::User.new(res.symbolize_keys)
      end
    end
  end
end
