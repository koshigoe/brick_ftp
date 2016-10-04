module BrickFTP
  module API
    class Group < Base
      endpoint :get,    :index,  '/api/rest/v1/groups.json'
      endpoint :get,    :show,   '/api/rest/v1/groups/%{id}.json'
      endpoint :post,   :create, '/api/rest/v1/groups.json'
      endpoint :put,    :update, '/api/rest/v1/groups/%{id}.json'
      endpoint :delete, :delete, '/api/rest/v1/groups/%{id}.json'

      attribute :id
      attribute :name, writable: true
      attribute :notes, writable: true
      attribute :user_ids, writable: true
    end
  end
end
