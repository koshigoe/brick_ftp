# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    module RetrieveHistory
      using BrickFTP::CoreExt::Hash

      def retrieve(path, page, per_page, start_at)
        validate_page!(page)
        validate_per_page!(per_page)
        validate_start_at!(start_at)

        query = build_query(page, per_page, start_at)
        endpoint = path
        endpoint = "#{path}?#{query}" unless query.empty?
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::History.new(**i.symbolize_keys) }
      end

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

      def build_query(page, per_page, start_at)
        params = {}
        params[:page] = page if page
        params[:per_page] = per_page if per_page
        params[:start_at] = start_at.utc.iso8601 if start_at

        params.map { |k, v| "#{k}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
      end
    end
  end
end
