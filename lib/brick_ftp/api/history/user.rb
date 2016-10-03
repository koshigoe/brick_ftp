module BrickFTP
  module API
    module History
      class User < BrickFTP::API::Base
        define_api :index, '/api/rest/v1/history/users/%{user_id}.json', :page, :per_page, :start_at
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
