# frozen_string_literal: true

require 'brick_ftp/restful_api/restful'

module BrickFTP
  module RESTfulAPI
    class GetUser
      include RESTful

      # Returns a single user.
      #
      # @param [Integer] id Globally unique identifier of each user.
      #   Each user is given an ID automatically upon creation.
      # @return [BrickFTP::Types::User, nil] found User or nil
      #
      def call(id)
        res = client.get("/api/rest/v1/users/#{id}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::User.new(res.symbolize_keys)
      end
    end
  end
end
