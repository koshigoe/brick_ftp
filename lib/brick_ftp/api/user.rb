module BrickFTP
  module API
    class User
      def self.all
        BrickFTP::HTTPClient.new.get('/api/rest/v1/users.json').map { |x| new(x.symbolize_keys) }
      end

      def self.find(id)
        data = BrickFTP::HTTPClient.new.get("/api/rest/v1/users/#{id}.json")
        data.empty? ? nil : new(data.symbolize_keys)
      end

      def self.create(username:, password: nil, name: nil, email: nil, notes: nil, group_ids: nil,
                     ftp_permission: nil, web_permission: nil, sftp_permission: nil, dav_permission: nil,
                     restapi_permission: nil, attachments_permission: nil, self_managed: nil, require_password_change: nil,
                     allowed_ips: nil, user_root: nil, grant_permission: nil, ssl_required: nil, authentication_method: nil)
        params = Hash[binding.local_variables.map { |_| [_, binding.local_variable_get(_)] }].reject { |_, v| v.nil? }
        data = BrickFTP::HTTPClient.new.post('/api/rest/v1/users.json', params: params)
        new(data.symbolize_keys)
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
                  :authentication_method,
                  :last_login_at,
                  :time_zone,
                  :language,
                  :site_admin

      def initialize(id: nil, username: nil, password: nil, name: nil, email: nil, notes: nil, group_ids: nil,
                     ftp_permission: nil, web_permission: nil, sftp_permission: nil, dav_permission: nil,
                     restapi_permission: nil, attachments_permission: nil, self_managed: nil, require_password_change: nil,
                     allowed_ips: nil, user_root: nil, grant_permission: nil, ssl_required: nil, authentication_method: nil,
                     last_login_at: nil, time_zone: nil, language: nil, site_admin: nil)
        binding.local_variables.map do |_|
          instance_variable_set(:"@#{_}", binding.local_variable_get(_))
        end
      end
    end
  end
end
