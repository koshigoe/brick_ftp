module BrickFTP
  module API
    module History
      class File < BrickFTP::API::Base
        define_api :index, '/api/rest/v1/history/files/%{path}'
        define_readonly_attributes :id,
                                   :when,
                                   :user_id,
                                   :username,
                                   :action,
                                   :failure_type,
                                   :path,
                                   :source,
                                   :destination,
                                   :targets,
                                   :ip,
                                   :interface
      end
    end
  end
end
