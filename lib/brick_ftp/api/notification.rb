module BrickFTP
  module API
    class Notification < Base
      endpoint :index,  '/api/rest/v1/notifications.json'
      endpoint :create, '/api/rest/v1/notifications.json'
      endpoint :delete, '/api/rest/v1/notifications/%{id}.json'

      attribute :id
      attribute :path, writable: true
      attribute :user_id, writable: true
      attribute :username, writable: true
    end
  end
end
