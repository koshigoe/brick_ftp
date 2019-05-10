# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Retrieve user history
    #
    # @see https://developers.files.com/#retrieve-user-history Retrieve user history
    #
    # ### Params
    #
    # PARAMETER | TYPE     | DESCRIPTION
    # --------- | -------- | -----------
    # page      | integer  | Optional page number of items to return in this request.
    # per_page  | integer  | Optional requested number of items returned per request. Default: 1000, maximum: 10000. Leave blank for default (strongly recommended).
    # start_at  | datetime | Optional date and time in the history to start from.
    #
    class RetrieveUserHistory
      include Command
      include RetrieveHistory

      # Returns user history only.
      #
      # - The history starts with the most recent entries and proceeds back in time.
      # - There is a maximum number of records that will be returned with a single request
      #   (default 1000 or whatever value you provide as the per_page parameter, up to a maximum of 10,000).
      #
      # @param [Integer] id Globally unique identifier of each user.
      #   Each user is given an ID automatically upon creation.
      # @param [Integer] page Optional page number of items to return in this request.
      # @param [Integer] per_page Optional requested number of items returned per request.
      #   Default: 1000, maximum: 10000. Leave blank for default (strongly recommended).
      # @param [Time] start_at Optional date and time in the history to start from.
      # @return [Array<BrickFTP::Types::History>] History
      #
      def call(id, page: nil, per_page: nil, start_at: nil)
        retrieve("/api/rest/v1/history/users/#{id}.json", page, per_page, start_at)
      end
    end
  end
end
