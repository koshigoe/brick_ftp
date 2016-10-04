module BrickFTP
  module API
    class Notification < Base
      define_api :index,  '/api/rest/v1/notifications.json'
      define_api :create, '/api/rest/v1/notifications.json'
      define_api :delete, '/api/rest/v1/notifications/%{id}.json'

      attribute :id
      attribute :path, writable: true
      attribute :user_id, writable: true
      attribute :username, writable: true
    end
  end
end
