module BrickFTP
  module API
    class Notification < Base
      define_api :index,  '/api/rest/v1/notifications.json'
      define_api :create, '/api/rest/v1/notifications.json'
      define_api :delete, '/api/rest/v1/notifications/%{id}.json'
      define_writable_attributes :path, :user_id, :username
      define_readonly_attributes :id
    end
  end
end
