# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Search users
    #
    # @see https://developers.brickftp.com/#search-users Search users
    #
    class SearchUser
      include Command
      using BrickFTP::CoreExt::Hash

      # Returns a single user.
      #
      # @param [String] username Username for the user. This is how the user will be displayed on the site.
      #   Maximum of 50 characters.
      # @return [BrickFTP::Types::User, nil] found User or nil
      #
      def call(username)
        res = client.get("/api/rest/v1/users.json?q[username]=#{ERB::Util.url_encode(username)}")
        return nil if !res || res.empty?

        BrickFTP::Types::User.new(res.first.symbolize_keys)
      end
    end
  end
end
