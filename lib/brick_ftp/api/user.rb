module BrickFTP
  module API
    class User
      def self.all
        BrickFTP::HTTPClient.new.get('/api/rest/v1/users.json').map { |x| new(x.symbolize_keys) }
      end

      attr_reader :id,
                  :username,
                  :password,
                  :name,
                  :email,
                  :notes,
                  :group_ids,
                  :ftp_permission,
                  :web_permission,
                  :sftp_permission,
                  :dav_permission,
                  :restapi_permission,
                  :attachments_permission,
                  :self_managed,
                  :require_password_change,
                  :allowed_ips,
                  :user_root,
                  :grant_permission,
                  :ssl_required,
                  :authentication_method

      def initialize(id: nil, username: nil, password: nil, name: nil, email: nil, notes: nil, group_ids: nil,
                     ftp_permission: nil, web_permission: nil, sftp_permission: nil, dav_permission: nil,
                     restapi_permission: nil, attachments_permission: nil, self_managed: nil, require_password_change: nil,
                     allowed_ips: nil, user_root: nil, grant_permission: nil, ssl_required: nil, authentication_method: nil)
        @id = id
        @username = username
        @password = password
        @name = name
        @email = email
        @notes = notes
        @group_ids = group_ids
        @ftp_permission = ftp_permission
        @web_permission = web_permission
        @sftp_permission = sftp_permission
        @dav_permission = dav_permission
        @restapi_permission = restapi_permission
        @attachments_permission = attachments_permission
        @self_managed = self_managed
        @require_password_change = require_password_change
        @allowed_ips = allowed_ips
        @user_root = user_root
        @grant_permission = grant_permission
        @ssl_required = ssl_required
        @authentication_method = authentication_method
      end
    end
  end
end
