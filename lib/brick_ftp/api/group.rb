module BrickFTP
  module API
    class Group < Base
      define_api :index,  '/api/rest/v1/groups.json'
      define_api :show,   '/api/rest/v1/groups/%{id}.json'
      define_api :create, '/api/rest/v1/groups.json'
      define_api :update, '/api/rest/v1/groups/%{id}.json'
      define_api :delete, '/api/rest/v1/groups/%{id}.json'

      attribute :id
      attribute :name, writable: true
      attribute :notes, writable: true
      attribute :user_ids, writable: true
    end
  end
end
