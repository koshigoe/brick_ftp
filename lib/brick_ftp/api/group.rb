module BrickFTP
  module API
    class Group < Base
      endpoint :index,  '/api/rest/v1/groups.json'
      endpoint :show,   '/api/rest/v1/groups/%{id}.json'
      endpoint :create, '/api/rest/v1/groups.json'
      endpoint :update, '/api/rest/v1/groups/%{id}.json'
      endpoint :delete, '/api/rest/v1/groups/%{id}.json'

      attribute :id
      attribute :name, writable: true
      attribute :notes, writable: true
      attribute :user_ids, writable: true
    end
  end
end
