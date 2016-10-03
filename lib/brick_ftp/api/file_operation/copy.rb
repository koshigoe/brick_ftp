module BrickFTP
  module API
    module FileOperation
      class Copy < BrickFTP::API::Base
        define_api :create, '/api/rest/v1/files/%{path}'
        define_writable_attributes :'copy-destination'
      end
    end
  end
end
