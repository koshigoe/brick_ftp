module BrickFTP
  module API
    module History
      class User < BrickFTP::API::Base
        endpoint :get, :index, '/api/rest/v1/history/users/%{user_id}.json', :page, :per_page, :start_at

        attribute :id
        attribute :when
        attribute :user_id
        attribute :username
        attribute :action
        attribute :failure_type
        attribute :path
        attribute :source
        attribute :destination
        attribute :targets
        attribute :ip
        attribute :interface
        attribute :display
      end
    end
  end
end
