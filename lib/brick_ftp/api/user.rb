module BrickFTP
  module API
    class User
      class UndefinedAttributesError < StandardError
        def initialize(undefined_attributes = [])
          super "No such attributes: #{undefined_attributes.join(', ')}"
        end
      end

      def self.all
        BrickFTP::HTTPClient.new.get('/api/rest/v1/users.json').map { |x| new(x.symbolize_keys) }
      end

      def self.find(id)
        data = BrickFTP::HTTPClient.new.get("/api/rest/v1/users/#{id}.json")
        data.empty? ? nil : new(data.symbolize_keys)
      end

      WRITABLE_ATTRIBUTES = [
        :username, :password, :name, :email, :notes, :group_ids, :ftp_permission, :web_permission, :sftp_permission,
        :dav_permission, :restapi_permission, :attachments_permission, :self_managed, :require_password_change,
        :allowed_ips, :user_root, :grant_permission, :ssl_required, :authentication_method
      ].freeze

      READONLY_ATTRIBUTES = [:id, :last_login_at, :time_zone, :language, :site_admin].freeze

      ATTRIBUTES = (WRITABLE_ATTRIBUTES + READONLY_ATTRIBUTES).freeze

      def self.create(params = {})
        undefined_attributes = params.keys - WRITABLE_ATTRIBUTES
        raise UndefinedAttributesError, undefined_attributes unless undefined_attributes.empty?

        data = BrickFTP::HTTPClient.new.post('/api/rest/v1/users.json', params: params)
        new(data.symbolize_keys)
      end

      attr_reader *ATTRIBUTES

      def initialize(params = {})
        undefined_attributes = params.keys - ATTRIBUTES
        raise UndefinedAttribuftesError, undefined_attributes unless undefined_attributes.empty?

        params.each { |k, v| instance_variable_set(:"@#{k}", v) }
      end

      def update(params = {})
        undefined_attributes = params.keys - WRITABLE_ATTRIBUTES
        raise UndefinedAttributesError, undefined_attributes unless undefined_attributes.empty?

        data = BrickFTP::HTTPClient.new.put("/api/rest/v1/users/#{id}.json", params: params)
        data.each do |k, v|
          instance_variable_set(:"@#{k}", v)
        end

        self
      end

      def destroy
        BrickFTP::HTTPClient.new.delete("/api/rest/v1/users/#{id}.json")
        true
      end
    end
  end
end
