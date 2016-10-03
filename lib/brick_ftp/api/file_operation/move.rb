module BrickFTP
  module API
    module FileOperation
      class Move < BrickFTP::API::Base
        define_api :create, '/api/rest/v1/files/%{path}'
        define_writable_attributes :'move-destination'
      end
    end
  end
end
