# frozen_string_literal: true

module BrickFTP
  module API
    module FileOperation
      class Copy < BrickFTP::API::Base
        endpoint :post, :create, '/api/rest/v1/files/%{path}'
        attribute :'copy-destination', writable: true
      end
    end
  end
end
