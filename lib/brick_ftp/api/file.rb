module BrickFTP
  module API
    class File < Base
      define_api :show,   '/api/rest/v1/files/%{path}'
      define_api :delete, '/api/rest/v1/files/%{path}'
      define_readonly_attributes :path, :type, :size, :mtime, :crc32, :md5, :download_uri
    end
  end
end
