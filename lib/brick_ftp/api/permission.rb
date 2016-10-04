module BrickFTP
  module API
    class Permission < Base
      endpoint :index,  '/api/rest/v1/permissions.json'
      endpoint :create, '/api/rest/v1/permissions.json'
      endpoint :delete, '/api/rest/v1/permissions/%{id}.json'

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
