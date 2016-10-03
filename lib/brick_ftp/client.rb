module BrickFTP
  class Client
    # Login and store authentication session.
    # @see https://brickftp.com/ja/docs/rest-api/authentication/
    # @param username [String] username of BrickFTP's user.
    # @param password [String] password of BrickFTP's user.
    def login(username, password)
      BrickFTP::API::Authentication.login(username, password)
    end

    # Logout and discard authentication session.
    # @see https://brickftp.com/ja/docs/rest-api/authentication/
    def logout
      BrickFTP::API::Authentication.logout
    end

    # List all users on the current site.
    # @see https://brickftp.com/ja/docs/rest-api/users/
    # @return [Array] array of BrickFTP::API::User
    def list_users
      BrickFTP::API::User.all
    end

    # Show a single user.
    # @see https://brickftp.com/ja/docs/rest-api/users/
    # @param id user id.
    # @return [BrickFTP::API::User] user object.
    def show_user(id)
      BrickFTP::API::User.find(id)
    end

    # Create a new user on the current site.
    # @see https://brickftp.com/ja/docs/rest-api/users/
    # @param attributes [Hash] User's attributes.
    def create_user(attributes)
      BrickFTP::API::User.create(attributes)
    end

    # Update an existing user.
    # @see https://brickftp.com/ja/docs/rest-api/users/
    # @param user [BrickFTP::API::User] user object.
    # @param attributes [Hash] User's attributes.
    # @return [BrickFTP::API::User] user object.
    def update_user(user, attributes)
      user.update(attributes)
    end

    # Delete a user.
    # @see https://brickftp.com/ja/docs/rest-api/users/
    # @param user [BrickFTP::API::User] user object.
    # @return [Boolean] return true.
    def delete_user(user)
      user.destroy
    end

    # List all groups on the current site.
    # @see https://brickftp.com/ja/docs/rest-api/groups/
    def list_groups
      BrickFTP::API::Group.all
    end

    # Show a single group.
    # @see https://brickftp.com/ja/docs/rest-api/groups/
    # @param id group id.
    # @return [BrickFTP::API::Group] group object.
    def show_group(id)
      BrickFTP::API::Group.find(id)
    end

    # Create a new group on the current site.
    # @see https://brickftp.com/ja/docs/rest-api/groups/
    # @param attributes [Hash] Group's attributes.
    def create_group(attributes)
      BrickFTP::API::Group.create(attributes)
    end

    # Update an existing group.
    # @see https://brickftp.com/ja/docs/rest-api/groups/
    # @param group [BrickFTP::API::Group] group object.
    # @param attributes [Hash] Group's attributes.
    # @return [BrickFTP::API::Group] group object.
    def update_group(group, attributes)
      group.update(attributes)
    end

    # Delete a group.
    # @see https://brickftp.com/ja/docs/rest-api/groups/
    # @param group [BrickFTP::API::Group] group object.
    # @return [Boolean] return true.
    def delete_group(group)
      group.destroy
    end

    # List all permissions on the current site.
    # @see https://brickftp.com/ja/docs/rest-api/permissions/
    def list_permissions
      BrickFTP::API::Permission.all
    end

    # Create a new permission on the current site.
    # @see https://brickftp.com/ja/docs/rest-api/permissions/
    # @param attributes [Hash] Permission's attributes.
    def create_permission(attributes)
      BrickFTP::API::Permission.create(attributes)
    end

    # Delete a permission.
    # @see https://brickftp.com/ja/docs/rest-api/permissions/
    # @param permission [BrickFTP::API::Permission] permission object.
    # @return [Boolean] return true.
    def delete_permission(permission)
      permission.destroy
    end

    # List all notifications on the current site.
    def list_notifications
      BrickFTP::API::Notification.all
    end

    # Create a new notification on the current site.
    # @param attributes [Hash] Notification's attributes.
    def create_notification(attributes)
      BrickFTP::API::Notification.create(attributes)
    end

    # Delete a notification.
    # @param notification [BrickFTP::API::Notification] notification object.
    # @return [Boolean] return true.
    def delete_notification(notification)
      notification.destroy
    end
  end
end
