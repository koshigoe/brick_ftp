# frozen_string_literal: true

require 'cgi'

module BrickFTP
  module RESTfulAPI
    class RetrieveSiteHistory
      include Command

      # Returns the entire history for the current site.
      #
      # - The history starts with the most recent entries and proceeds back in time.
      # - There is a maximum number of records that will be returned with a single request
      #   (default 1000 or whatever value you provide as the per_page parameter, up to a maximum of 10,000).
      #
      # @param [Integer] page Optional page number of items to return in this request.
      # @param [Integer] per_page Optional requested number of items returned per request.
      #   Default: 1000, maximum: 10000. Leave blank for default (strongly recommended).
      # @param [Time] start_at Optional date and time in the history to start from.
      # @return [Array<BrickFTP::Types::History>] History
      #
      def call(page: nil, per_page: nil, start_at: nil)
        validate_page!(page)
        validate_per_page!(per_page)
        validate_start_at!(start_at)

        params = {}
        params[:page] = page if page
        params[:per_page] = per_page if per_page
        params[:start_at] = start_at.utc.iso8601 if start_at
        query = params.map { |k, v| "#{k}=#{CGI.escape(v.to_s)}" }.join('&')

        endpoint = '/api/rest/v1/history.json'
        endpoint = "#{endpoint}?#{query}" unless query.empty?
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::History.new(i.symbolize_keys) }
      end

      private

      def validate_page!(page)
        return if page.nil?
        return if page.is_a?(Integer) && page.positive?

        raise ArgumentError, 'page must be greater than 0.'
      end

      MAX_PER_PAGE = 10_000

      def validate_per_page!(per_page)
        return if per_page.nil?
        return if per_page.is_a?(Integer) && per_page.positive? && per_page <= MAX_PER_PAGE

        raise ArgumentError, "per_page must be greater than 0 and less than equal #{MAX_PER_PAGE}."
      end

      def validate_start_at!(start_at)
        return if start_at.nil?
        return if start_at.is_a?(Time)

        raise ArgumentError, 'start_at must be a Time.'
      end
    end
  end
end
