# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class ListUsers
      include Command

      DEFAULT_PAGE = 1
      DEFAULT_PER_PAGE = 1_000

      # Returns a list of users on the current site.
      #
      # @param [Integer] page Optional page number of items to return in this request.
      #   Default: 1.
      # @param [Integer] per_page Optional requested number of items returned per request.
      #   Default: 1000. Leave blank for default (strongly recommended).
      # @return [Array<BrickFTP::Types::User>] Users
      #
      def call(page: DEFAULT_PAGE, per_page: DEFAULT_PER_PAGE)
        validate_page!(page)
        validate_per_page!(per_page)

        res = client.get("/api/rest/v1/users.json?page=#{page}&per_page=#{per_page}")

        res.map { |i| BrickFTP::Types::User.new(i.symbolize_keys) }
      end

      private

      def validate_page!(page)
        return if page.is_a?(Integer) && page.positive?

        raise ArgumentError, 'page must be greater than 0.'
      end

      def validate_per_page!(per_page)
        return if per_page.is_a?(Integer) && per_page.positive?

        raise ArgumentError, 'per_page must be greater than 0.'
      end
    end
  end
end
