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
      # @param method [Symbol] any one of :index, :show, :create, :update, :destroy
      # @param path_template [Stryng] template of endpoint path.
      # @param query_keys [Array] array of query_string's parameter name.
      def endpoint(method, path_template, *query_keys)
        endpoints[method] = { path_template: path_template, query_keys: query_keys }
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
        attr_reader name.to_s.tr('-', '_')
      end

      # Return all attributes.
      # @return [Array]
      def attributes
        writable_attributes + readonly_attributes
      end

      # Build path for API endpoint.
      # @param method [Symbol]
      # @param params [Hash] mixed path parameters and query parameters.
      # @return [String]
      def api_path_for(method, params = {})
        api_component_for(method).path(params)
      end

      # Build BrickFTP::APIComponent for specified method.
      # @param method [Symbol]
      # @return [BrickFTP::APIComponent]
      def api_component_for(method)
        raise BrickFTP::API::NoSuchAPI, "#{method} #{self.name}" unless endpoints.key?(method)
        BrickFTP::APIComponent.new(endpoints[method][:path_template], endpoints[method][:query_keys])
      end
    end
  end
end
