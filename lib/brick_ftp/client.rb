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
    # @see https://brickftp.com/ja/docs/rest-api/notifications/
    def list_notifications
      BrickFTP::API::Notification.all
    end

    # Create a new notification on the current site.
    # @see https://brickftp.com/ja/docs/rest-api/notifications/
    # @param attributes [Hash] Notification's attributes.
    def create_notification(attributes)
      BrickFTP::API::Notification.create(attributes)
    end

    # Delete a notification.
    # @see https://brickftp.com/ja/docs/rest-api/notifications/
    # @param notification [BrickFTP::API::Notification] notification object.
    # @return [Boolean] return true.
    def delete_notification(notification)
      notification.destroy
    end

    # Show the entire history for the current site.
    # @see https://brickftp.com/ja/docs/rest-api/history/
    # @param page [Integer] Page number of items to return in this request.
    # @param per_page [Integer] Requested number of items returned per request. Default: 1000, maximum: 10000. Leave blank for default (strongly recommended).
    # @param start_at [String] Date and time in the history to start from.
    # @return [Array] array of `BrickFTP::API::History::Site`
    def list_site_history(page: nil, per_page: nil, start_at: nil)
      query = { page: page, per_page: per_page, start_at: start_at }.reject { |_, v| v.nil? }
      BrickFTP::API::History::Site.all(query)
    end

    # Show login history only.
    # @see https://brickftp.com/ja/docs/rest-api/history/
    # @param page [Integer] Page number of items to return in this request.
    # @param per_page [Integer] Requested number of items returned per request. Default: 1000, maximum: 10000. Leave blank for default (strongly recommended).
    # @param start_at [String] Date and time in the history to start from.
    # @return [Array] array of `BrickFTP::API::History::Login`
    def list_login_history(page: nil, per_page: nil, start_at: nil)
      query = { page: page, per_page: per_page, start_at: start_at }.reject { |_, v| v.nil? }
      BrickFTP::API::History::Login.all(query)
    end

    # Show all history for a specific user.
    # @see https://brickftp.com/ja/docs/rest-api/history/
    # @param page [Integer] Page number of items to return in this request.
    # @param per_page [Integer] Requested number of items returned per request. Default: 1000, maximum: 10000. Leave blank for default (strongly recommended).
    # @param start_at [String] Date and time in the history to start from.
    # @return [Array] array of `BrickFTP::API::History::User`
    def list_user_history(page: nil, per_page: nil, start_at: nil)
      query = { page: page, per_page: per_page, start_at: start_at }.reject { |_, v| v.nil? }
      BrickFTP::API::History::User.all(query)
    end

    # Show all history for a specific folder.
    # @see https://brickftp.com/ja/docs/rest-api/history/
    # @param path [String] path of folder.
    # @param page [Integer] Page number of items to return in this request.
    # @param per_page [Integer] Requested number of items returned per request. Default: 1000, maximum: 10000. Leave blank for default (strongly recommended).
    # @param start_at [String] Date and time in the history to start from.
    # @return [Array] array of `BrickFTP::API::History::Folder`
    def list_folder_history(path:, page: nil, per_page: nil, start_at: nil)
      query = { path: path, page: page, per_page: per_page, start_at: start_at }.reject { |_, v| v.nil? }
      BrickFTP::API::History::Folder.all(query)
    end

    # Show all history for a specific file.
    # @see https://brickftp.com/ja/docs/rest-api/history/
    # @param path [String] path of file.
    # @param page [Integer] Page number of items to return in this request.
    # @param per_page [Integer] Requested number of items returned per request. Default: 1000, maximum: 10000. Leave blank for default (strongly recommended).
    # @param start_at [String] Date and time in the history to start from.
    # @return [Array] array of `BrickFTP::API::History::File`
    def list_file_history(path:, page: nil, per_page: nil, start_at: nil)
      query = { path: path, page: page, per_page: per_page, start_at: start_at }.reject { |_, v| v.nil? }
      BrickFTP::API::History::File.all(query)
    end

    # List all bundles on the current site.
    # @see https://brickftp.com/ja/docs/rest-api/bundles/
    # @return [Array] array of BrickFTP::API::Bundle
    def list_bundles
      BrickFTP::API::Bundle.all
    end

    # Show a single bundle.
    # @see https://brickftp.com/ja/docs/rest-api/bundles/
    # @param id bundle id.
    # @return [BrickFTP::API::Bundle] bundle object.
    def show_bundle(id)
      BrickFTP::API::Bundle.find(id)
    end

    # Create a new bundle on the current site.
    # @see https://brickftp.com/ja/docs/rest-api/bundles/
    # @param attributes [Hash] Bundle's attributes.
    def create_bundle(attributes)
      BrickFTP::API::Bundle.create(attributes)
    end

    # Delete a bundle.
    # @see https://brickftp.com/ja/docs/rest-api/bundles/
    # @param bundle [BrickFTP::API::Bundle] bundle object.
    # @return [Boolean] return true.
    def delete_bundle(bundle)
      bundle.destroy
    end

    # List the contents of a bundle.
    # @see https://brickftp.com/ja/docs/rest-api/bundles/
    # @param path [String]
    # @param code [String]
    # @param host [String]
    # @return [Array] array of `BrickFTP::API::BundleContent`.
    def list_bundle_contents(path: nil, code:, host:)
      BrickFTP::API::BundleContent.all(path: path, code: code, host: host)
    end

    # Provides download URLs that will enable you to download the files in a bundle.
    # @see https://brickftp.com/ja/docs/rest-api/bundles/
    # @param code [String]
    # @param host [String]
    # @param paths [Array] array of path string.
    # @return [Array] array of `BrickFTP::API::BundleDownload`.
    def list_bundle_downloads(code:, host:, paths: [])
      BrickFTP::API::BundleDownload.all(code: code, host: host, paths: paths)
    end
  end
end
