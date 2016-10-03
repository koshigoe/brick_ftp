require 'cgi'

module BrickFTP
  module API
    module Authentication
      COOKIE_NAME = 'BrickFTP'.freeze

      # Generate authentication cookie.
      # @param session [BrickFTP::API::Authentication::Session] authentication session object.
      # @return [CGI::Cookie] authentication cookie.
      def self.cookie(session)
        CGI::Cookie.new(COOKIE_NAME, session.id)
      end

      # Alias for `BrickFTP::API::Authentication::Session.create`.
      # @param username [String] username of BrickFTP's user.
      # @param password [String] password of BrickFTP's user.
      def self.login(username, password)
        Session.create(username: username, password: password)
      end

      # Alias for `BrickFTP::API::Authentication::Session#destroy`.
      def self.logout
        BrickFTP.config.session.destroy
      end
    end
  end
end
