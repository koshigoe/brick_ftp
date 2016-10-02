module BrickFTP
  module API
    class Folder < Base
      define_api :index,  '/api/rest/v1/folders/%{path}'
      define_api :create, '/api/rest/v1/folders/%{path}'
      define_readonly_attributes :id, :path, :type, :size, :mtime, :crc32, :md5

      def self.create(path_params = {})
        super({}, path_params)
      end
    end
  end
end
