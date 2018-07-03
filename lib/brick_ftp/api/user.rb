# frozen_string_literal: true

module BrickFTP
  module API
    class User < Base
      endpoint :get,    :index,  '/api/rest/v1/users.json'
      endpoint :get,    :show,   '/api/rest/v1/users/%{id}.json'
      endpoint :post,   :create, '/api/rest/v1/users.json'
      endpoint :put,    :update, '/api/rest/v1/users/%{id}.json'
      endpoint :delete, :delete, '/api/rest/v1/users/%{id}.json'

      attribute :id
      attribute :last_login_at
      attribute :time_zone
      attribute :language
      attribute :site_admin
      attribute :username, writable: true
      attribute :password, writable: true
      attribute :name, writable: true
      attribute :email, writable: true
      attribute :notes, writable: true
      attribute :group_ids, writable: true
      attribute :ftp_permission, writable: true
      attribute :web_permission, writable: true
      attribute :sftp_permission, writable: true
      attribute :dav_permission, writable: true
      attribute :restapi_permission, writable: true
      attribute :attachments_permission, writable: true
      attribute :self_managed, writable: true
      attribute :require_password_change, writable: true
      attribute :allowed_ips, writable: true
      attribute :user_root, writable: true
      attribute :grant_permission, writable: true
      attribute :ssl_required, writable: true
      attribute :authentication_method, writable: true
    end
  end
end
