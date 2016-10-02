module BrickFTP
  module API
    class User < Base
      define_api :index,  '/api/rest/v1/users.json'
      define_api :show,   '/api/rest/v1/users/%{id}.json'
      define_api :create, '/api/rest/v1/users.json'
      define_api :update, '/api/rest/v1/users/%{id}.json'
      define_api :delete, '/api/rest/v1/users/%{id}.json'
      define_writable_attributes :username,
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
      define_readonly_attributes :id,
                                 :last_login_at,
                                 :time_zone,
                                 :language,
                                 :site_admin
    end
  end
end
