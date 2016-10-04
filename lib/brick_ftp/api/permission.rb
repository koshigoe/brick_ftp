module BrickFTP
  module API
    class Permission < Base
      define_api :index,  '/api/rest/v1/permissions.json'
      define_api :create, '/api/rest/v1/permissions.json'
      define_api :delete, '/api/rest/v1/permissions/%{id}.json'

      attribute :id
      attribute :recursive
      attribute :path, writable: true
      attribute :permission, writable: true
      attribute :user_id, writable: true
      attribute :username, writable: true
      attribute :group_id, writable: true
    end
  end
end
