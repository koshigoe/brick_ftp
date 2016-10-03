module BrickFTP
  class Client
    # Login and store authentication session.
    # @param username [String] username of BrickFTP's user.
    # @param password [String] password of BrickFTP's user.
    def login(username, password)
      BrickFTP::API::Authentication.login(username, password)
    end

    # Logout and discard authentication session.
    def logout
      BrickFTP::API::Authentication.logout
    end
  end
end
