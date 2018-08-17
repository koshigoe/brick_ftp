# frozen_string_literal: true

require 'brick_ftp/commands/restful'
require 'cgi'

module BrickFTP
  module Commands
    class SearchUser
      include RESTful

      # Returns a single user.
      #
      # @param [String] username Username for the user. This is how the user will be displayed on the site.
      #   Maximum of 50 characters.
      # @return [BrickFTP::Types::User, nil] found User or nil
      #
      def call(username:)
        res = client.get("/api/rest/v1/users.json?q[username]=#{CGI.escape(username)}")
        return nil if !res || res.empty?

        BrickFTP::Types::User.new(res.first.symbolize_keys)
      end
    end
  end
end
