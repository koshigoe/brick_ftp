module BrickFTP
  module API
    module History
      class Folder < BrickFTP::API::Base
        endpoint :get, :index, '/api/rest/v1/history/folders/%{path}', :page, :per_page, :start_at

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
