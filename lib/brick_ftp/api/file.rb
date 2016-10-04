module BrickFTP
  module API
    class File < Base
      define_api :show,   '/api/rest/v1/files/%{path}'
      define_api :delete, '/api/rest/v1/files/%{path}'

      attribute :id
      attribute :path
      attribute :type
      attribute :size
      attribute :mtime
      attribute :crc32
      attribute :md5
      attribute :download_uri
      attribute :provided_mtime
      attribute :permissions
    end
  end
end
