module BrickFTP
  module API
    module FileOperation
      class Copy < BrickFTP::API::Base
        define_api :create, '/api/rest/v1/files/%{path}'
        attribute :'copy-destination', writable: true
      end
    end
  end
end
