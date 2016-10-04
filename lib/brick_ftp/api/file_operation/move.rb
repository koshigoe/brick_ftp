module BrickFTP
  module API
    module FileOperation
      class Move < BrickFTP::API::Base
        endpoint :post, :create, '/api/rest/v1/files/%{path}'
        attribute :'move-destination', writable: true
      end
    end
  end
end
