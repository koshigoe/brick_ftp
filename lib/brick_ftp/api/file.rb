module BrickFTP
  module API
    class File < Base
      endpoint :get,    :show,   '/api/rest/v1/files/%{path}', :action
      endpoint :delete, :delete, '/api/rest/v1/files/%{path}'

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
