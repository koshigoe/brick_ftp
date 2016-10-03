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

    # List all users on the current site.
    # @return [Array] array of BrickFTP::API::User
    def list_users
      BrickFTP::API::User.all
    end

    # Show a single user.
    # @return [BrickFTP::API::User] user object.
    def show_user(id)
      BrickFTP::API::User.find(id)
    end

    # Create a new user on the current site.
    # @param attributes [Hash] User's attributes.
    def create_user(attributes)
      BrickFTP::API::User.create(attributes)
    end

    # Update an existing user.
    # @param user [BrickFTP::API::User] user object.
    # @param attributes [Hash] User's attributes.
    # @return [BrickFTP::API::User] user object.
    def update_user(user, attributes)
      user.update(attributes)
    end

    # Delete a user.
    # @param user [BrickFTP::API::User] user object.
    # @return [Boolean] return true.
    def delete_user(user)
      user.destroy
    end
  end
end
