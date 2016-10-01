require 'cgi'

module BrickFTP
  module Authentication
    COOKIE_NAME = 'BrickFTP'.freeze

    def self.cookie(session)
      CGI::Cookie.new(COOKIE_NAME, session.id)
    end
  end
end
