module BrickFTP
  module API
    class Permission < Base
      define_api :index,  '/api/rest/v1/permissions.json'
      define_api :create, '/api/rest/v1/permissions.json'
      define_api :delete, '/api/rest/v1/permissions/%{id}.json'
      define_writable_attributes :path, :permission, :user_id, :username, :group_id
      define_readonly_attributes :id
    end
  end
end
