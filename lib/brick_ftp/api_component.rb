# frozen_string_literal: true

require 'erb'

module BrickFTP
  class APIComponent
    attr_reader :path_template, :query_keys

    def initialize(path_template, query_keys = [])
      @path_template = path_template.respond_to?(:call) ? path_template : ->(_) { path_template }
      @query_keys = query_keys.map(&:to_sym)
    end

    def path(params)
      params = normalize_params(params)

      path_params = build_path_params_from(params)
      escaped_path_params = path_params.each_with_object({}) do |(k, v), res|
        res[k] = ERB::Util.url_encode(v.to_s)
      end

      path = path_template.call(params) % escaped_path_params
      query = build_query_string_from(params)
      query.empty? ? path : "#{path}?#{query}"
    end

    def build_path_params_from(params = {})
      params = normalize_params(params)

      path_variables(params).each_with_object({}) do |key, res|
        res[key] = params[key]
      end
    end

    def build_query_params_from(params = {})
      params = normalize_params(params)

      query_keys.each_with_object({}) do |name, res|
        next unless params.key?(name)
        res[name] = params[name]
      end
    end

    def build_query_string_from(params = {})
      params = normalize_params(params)

      pairs = build_query_params_from(params).each_with_object([]) do |(k, v), res|
        res << "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"
      end
      pairs.join('&')
    end

    def except_path_and_query(params = {})
      params = normalize_params(params)

      exceptions = path_variables(params) + query_keys
      params.reject { |k, _| exceptions.include?(k) }
    end

    private

    def path_variables(params = {})
      @path_variables ||= path_template.call(params).scan(/%\{([^}]+)\}/).map { |m| m.first.to_sym }
    end

    def normalize_params(params = {})
      case params
      when Hash
        params.symbolize_keys
      when BrickFTP::API::Base
        keys = path_variables(params) + query_keys
        keys.each_with_object({}) do |key, res|
          res[key] = params.read_property(key)
        end
      else
        keys = path_variables(params) + query_keys
        keys.each_with_object({}) do |key, res|
          res[key] = params
        end
      end
    end
  end
end
