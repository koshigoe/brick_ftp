module BrickFTP
  module API
    class Notification < Base
      endpoint :get,    :index,  '/api/rest/v1/notifications.json'
      endpoint :post,   :create, '/api/rest/v1/notifications.json'
      endpoint :delete, :delete, '/api/rest/v1/notifications/%{id}.json'

      attribute :id
      attribute :path, writable: true
      attribute :user_id, writable: true
      attribute :username, writable: true
    end
  end
end
