module BrickFTP
  module API
    class FolderBehavior < Base
      define_api :index, '/api/rest/v1/behaviors/folders/%{path}', :recursive
      define_readonly_attributes :id, :path, :behavior, :value
    end
  end
end
