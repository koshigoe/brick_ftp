module BrickFTP
  module API
    class FileCopy < Base
      define_api :create, '/api/rest/v1/files/%{path}'
      define_writable_attributes :'copy-destination'
    end
  end
end
