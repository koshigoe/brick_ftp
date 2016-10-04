module BrickFTP
  module API
    class FolderBehavior < Base
      endpoint :get, :index, '/api/rest/v1/behaviors/folders/%{path}', :recursive

      attribute :id
      attribute :path
      attribute :behavior
      attribute :value
    end
  end
end
