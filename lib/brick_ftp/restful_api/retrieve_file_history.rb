# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    class RetrieveFileHistory
      include Command
      include RetrieveHistory

      # Returns all history for a specific file.
      #
      # - The history starts with the most recent entries and proceeds back in time.
      # - There is a maximum number of records that will be returned with a single request
      #   (default 1000 or whatever value you provide as the per_page parameter, up to a maximum of 10,000).
      #
      # @param [String] path Path of the file or folder associated with the history entry.
      # @param [Integer] page Optional page number of items to return in this request.
      # @param [Integer] per_page Optional requested number of items returned per request.
      #   Default: 1000, maximum: 10000. Leave blank for default (strongly recommended).
      # @param [Time] start_at Optional date and time in the history to start from.
      # @return [Array<BrickFTP::Types::History>] History
      #
      def call(path, page: nil, per_page: nil, start_at: nil)
        retrieve("/api/rest/v1/history/files/#{ERB::Util.url_encode(path)}", page, per_page, start_at)
      end
    end
  end
end
