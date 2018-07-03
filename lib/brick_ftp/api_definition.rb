# frozen_string_literal: true

module BrickFTP
  module APIDefinition
    def self.included(klass)
      klass.class_eval do
        @endpoints = {}
        @writable_attributes = []
        @readonly_attributes = []

        class << self
          attr_reader :endpoints, :writable_attributes, :readonly_attributes
        end
      end

      klass.extend ClassMethods
    end

    module ClassMethods
      # Define API endpoint.
      # @param http_method [:Symbol] any one of :get, :post, :put, :delete
      # @param name [Symbol] any one of :index, :show, :create, :update, :destroy
      # @param path_template [Stryng] template of endpoint path.
      # @param query_keys [Array] array of query_string's parameter name.
      def endpoint(http_method, name, path_template, *query_keys)
        endpoints[name] = {
          http_method: http_method,
          path_template: path_template,
          query_keys: query_keys,
        }
      end

      # Define attribute.
      # @param name [Symbol] name of attribute.
      # @param writable [Boolean]
      def attribute(name, writable: false)
        if writable
          writable_attributes << name.to_sym
        else
          readonly_attributes << name.to_sym
        end
      end

      # Return all attributes.
      # @return [Array]
      def attributes
        writable_attributes + readonly_attributes
      end

      # Build path for API endpoint.
      # @param name [Symbol]
      # @param params [Hash] mixed path parameters and query parameters.
      # @return [String]
      def api_path_for(name, params = {})
        api_component_for(name).path(params)
      end

      # Build BrickFTP::APIComponent.
      # @param name [Symbol]
      # @return [BrickFTP::APIComponent]
      def api_component_for(name)
        raise BrickFTP::API::NoSuchAPI, "#{name} #{self.name}" unless endpoints.key?(name)
        BrickFTP::APIComponent.new(endpoints[name][:path_template], endpoints[name][:query_keys])
      end
    end
  end
end
