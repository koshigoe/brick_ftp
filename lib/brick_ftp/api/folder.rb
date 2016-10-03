module BrickFTP
  module API
    class Folder < Base
      define_api :index,  '/api/rest/v1/folders/%{path}', :page, :per_page, :search, :'sort_by[path]', :'sort_by[size]', :'sort_by[modified_at_datetime]'
      define_api :create, '/api/rest/v1/folders/%{path}'
      define_readonly_attributes :id, :path, :type, :size, :mtime, :crc32, :md5, :provided_mtime, :permissions

      def self.create(path_params = {})
        super({}, path_params)
      end
    end
  end
end
