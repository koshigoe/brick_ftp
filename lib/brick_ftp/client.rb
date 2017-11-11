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
    # @param user_or_id [BrickFTP::API::User, Integer] user object or user id.
    # @param attributes [Hash] User's attributes.
    # @return [BrickFTP::API::User] user object.
    def update_user(user_or_id, attributes)
      instantize_user(user_or_id).update(attributes)
    end

    # Delete a user.
    # @see https://brickftp.com/ja/docs/rest-api/users/
    # @param user_or_id [BrickFTP::API::User, Integer] user object or user id.
    # @return [Boolean] return true.
    def delete_user(user_or_id)
      instantize_user(user_or_id).destroy
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
    # @param user_id [Integer] User ID.
    # @param page [Integer] Page number of items to return in this request.
    # @param per_page [Integer] Requested number of items returned per request. Default: 1000, maximum: 10000. Leave blank for default (strongly recommended).
    # @param start_at [String] Date and time in the history to start from.
    # @return [Array] array of `BrickFTP::API::History::User`
    def list_user_history(user_id:, page: nil, per_page: nil, start_at: nil)
      query = { user_id: user_id, page: page, per_page: per_page, start_at: start_at }.reject { |_, v| v.nil? }
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

    # List all behaviors on the current site.
    # @see https://brickftp.com/ja/docs/rest-api/behaviors/
    # @return [Array] array of BrickFTP::API::Behavior
    def list_behaviors
      BrickFTP::API::Behavior.all
    end

    # Show a single behavior.
    # @see https://brickftp.com/ja/docs/rest-api/behaviors/
    # @param id behavior id.
    # @return [BrickFTP::API::Behavior] behavior object.
    def show_behavior(id)
      BrickFTP::API::Behavior.find(id)
    end

    # Create a new behavior on the current site.
    # @see https://brickftp.com/ja/docs/rest-api/behaviors/
    # @param attributes [Hash] Behavior's attributes.
    def create_behavior(attributes)
      BrickFTP::API::Behavior.create(attributes)
    end

    # Update an existing behavior.
    # @see https://brickftp.com/ja/docs/rest-api/behaviors/
    # @param behavior [BrickFTP::API::Behavior] behavior object.
    # @param attributes [Hash] Behavior's attributes.
    # @return [BrickFTP::API::Behavior] behavior object.
    def update_behavior(behavior, attributes)
      behavior.update(attributes)
    end

    # Delete a behavior.
    # @see https://brickftp.com/ja/docs/rest-api/behaviors/
    # @param behavior [BrickFTP::API::Behavior] behavior object.
    # @return [Boolean] return true.
    def delete_behavior(behavior)
      behavior.destroy
    end

    # shows the behaviors that apply to the given path.
    # @see https://brickftp.com/ja/docs/rest-api/behaviors/
    # @return [Array] array of BrickFTP::API::FolderBehavior
    def list_folder_behaviors(path:)
      BrickFTP::API::FolderBehavior.all(path: path)
    end

    # Lists the contents of the folder provided in the URL.
    # @see https://brickftp.com/ja/docs/rest-api/file-operations/
    # @param path [String]
    # @param page [Integer] Page number of items to return in this request.
    # @param per_page [Integer] Requested number of items returned per request. Maximum: 5000, leave blank for default (strongly recommended).
    # @param search [String] Only return items matching the given search text.
    # @param sort_by_path [String] Sort by file name, and value is either asc or desc to indicate normal or reverse sort. (Note that sort_by[path] = asc is the default.)
    # @param sort_by_size [String] Sort by file size, and value is either asc or desc to indicate smaller files first or larger files first, respectively.
    # @param sort_by_modified_at_datetime [String] Sort by modification time, and value is either asc or desc to indicate older files first or newer files first, respectively.
    # @return [Array] array of BrickFTP::API::Folder.
    def list_folders(path:, page: nil, per_page: nil, search: nil, sort_by_path: nil, sort_by_size: nil, sort_by_modified_at_datetime: nil)
      query = { path: path, page: page, per_page: per_page, search: search }.reject { |_, v| v.nil? }
      query[:'sort_by[path]'] = sort_by_path if sort_by_path
      query[:'sort_by[size]'] = sort_by_size if sort_by_size
      query[:'sort_by[modified_at_datetime]'] = sort_by_modified_at_datetime if sort_by_modified_at_datetime
      BrickFTP::API::Folder.all(query)
    end

    # Create a folder.
    # @see https://brickftp.com/ja/docs/rest-api/file-operations/
    # @param path [String]
    # @return [BrickFTP::API::Folder]
    def create_folder(path:)
      BrickFTP::API::Folder.create(path: path)
    end

    # provides a download URL that will enable you to download a file.
    # @see https://brickftp.com/ja/docs/rest-api/file-operations/
    # @param path [String] path for file.
    # @param omit_download_uri [Boolean] If true, omit download_uri. (Add query `action=stat`)
    # @return [BrickFTP::API::File] file object.
    def show_file(path, omit_download_uri: false)
      params = {}
      params[:action] = 'stat' if omit_download_uri
      BrickFTP::API::File.find(path, params: params)
    end

    # Move or renames a file or folder to the destination provided in the move_destination parameter.
    # @see https://brickftp.com/ja/docs/rest-api/file-operations/
    # @param path [String]
    # @param move_destination [String]
    # @return [BrickFTP::API::FileMove]
    def move_file(path:, move_destination:)
      BrickFTP::API::FileOperation::Move.create(path: path, :'move-destination' => move_destination)
    end

    # Copy a file or folder to the destination provided in the copy_destination parameter.
    # @see https://brickftp.com/ja/docs/rest-api/file-operations/
    # @param path [String]
    # @param copy_destination [String]
    # @return [BrickFTP::API::FileCopy]
    def copy_file(path:, copy_destination:)
      BrickFTP::API::FileOperation::Copy.create(path: path, :'copy-destination' => copy_destination)
    end

    # Delete a file.
    # @see https://brickftp.com/ja/docs/rest-api/file-operations/
    # @param file [BrickFTP::API::File] file object.
    # @param recursive: [Boolean]
    # @return [Boolean] return true.
    def delete_file(file, recursive: false)
      file.destroy(recursive: recursive)
    end

    # Upload file.
    # @see https://brickftp.com/ja/docs/rest-api/file-uploading/
    # @param path [String]
    # @param source [String] path for source file.
    # @return [BrickFTP::API::FileUpload]
    def upload_file(path:, source:)
      BrickFTP::API::FileOperation::Upload.create(path: path, source: source)
    end

    # Get usage of site.
    # @return [BrickFTP::API::SiteUsage]
    def site_usage
      BrickFTP::API::SiteUsage.find
    end

    private

    def instantize_user(user_or_id)
      return user_or_id if user_or_id.is_a?(BrickFTP::API::User)

      BrickFTP::API::User.new(id: user_or_id)
    end
  end
end
