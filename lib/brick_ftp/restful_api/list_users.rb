# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class ListUsers
      include Command

      # Returns a list of users on the current site.
      #
      # @param [Integer] page Optional page number of items to return in this request.
      #   Default: 1.
      # @param [Integer] per_page Optional requested number of items returned per request.
      #   Default: 1000. Leave blank for default (strongly recommended).
      # @return [Array<BrickFTP::Types::User>] Users
      #
      def call(page: nil, per_page: nil)
        validate_page!(page)
        validate_per_page!(per_page)

        params = {}
        params[:page] = page if page
        params[:per_page] = per_page if per_page
        query = params.map { |k, v| "#{k}=#{v}" }.join('&')

        endpoint = '/api/rest/v1/users.json'
        endpoint = "#{endpoint}?#{query}" unless query.empty?
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::User.new(i.symbolize_keys) }
      end

      private

      def validate_page!(page)
        return if page.nil?
        return if page.is_a?(Integer) && page.positive?

        raise ArgumentError, 'page must be greater than 0.'
      end

      def validate_per_page!(per_page)
        return if per_page.nil?
        return if per_page.is_a?(Integer) && per_page.positive?

        raise ArgumentError, 'per_page must be greater than 0.'
      end
    end
  end
end
