require 'cgi'

module BrickFTP
  module Authentication
    COOKIE_NAME = 'BrickFTP'.freeze

    def self.cookie(session)
      CGI::Cookie.new(COOKIE_NAME, session.id)
    end

    def self.login(username, password)
      Session.create(username, password)
    end

    def self.logout
      BrickFTP.config.session.destroy
    end
  end
end
