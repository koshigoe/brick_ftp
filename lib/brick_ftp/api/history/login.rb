module BrickFTP
  module API
    module History
      class Login < BrickFTP::API::Base
        define_api :index, '/api/rest/v1/history/login.json', :page, :per_page, :start_at

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
      end
    end
  end
end
