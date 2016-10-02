module BrickFTP
  module API
    class Group < Base
      define_api :index,  '/api/rest/v1/groups.json'
      define_api :show,   '/api/rest/v1/groups/%{id}.json'
      define_api :create, '/api/rest/v1/groups.json'
      define_api :update, '/api/rest/v1/groups/%{id}.json'
      define_api :delete, '/api/rest/v1/groups/%{id}.json'
      define_writable_attributes :name, :notes, :user_ids
      define_readonly_attributes :id
    end
  end
end
