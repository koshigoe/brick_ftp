require 'cgi'

module BrickFTP
  module API
    class Base
      class NoSuchAPIError < StandardError; end

      class UndefinedAttributesError < StandardError
        def initialize(undefined_attributes = [])
          super "No such attributes: #{undefined_attributes.join(', ')}"
        end
      end

      def self.inherited(subclass)
        subclass.instance_eval do
          @endpoints = {}
          @writable_attributes = []
          @readonly_attributes = []
        end
      end

      class << self
        attr_reader :endpoints, :writable_attributes, :readonly_attributes
      end

      def self.attributes
        writable_attributes + readonly_attributes
      end

      def self.endpoint(method, path_template, *query_keys)
        endpoints[method] = { path_template: path_template, query_keys: query_keys }
      end

      def self.attribute(name, writable: false)
        writable ? register_writable_attribute(name) : register_readonly_attribute(name)
      end

      def self.register_writable_attribute(name)
        @writable_attributes << name.to_sym
        attr_reader name.to_s.tr('-', '_')
      end

      def self.register_readonly_attribute(name)
        @readonly_attributes << name.to_sym
        attr_reader name.to_s.tr('-', '_')
      end

      def self.api_path_for(method, params = {})
        api_component_for(method).path(params)
      end

      def self.api_component_for(method)
        raise NoSuchAPIError, "#{method} #{self.name}" unless endpoints.key?(method)
        BrickFTP::APIComponent.new(endpoints[method][:path_template], endpoints[method][:query_keys])
      end

      def self.all(params = {})
        params.symbolize_keys!

        path = api_path_for(:index, params)
        BrickFTP::HTTPClient.new.get(path).map { |x| new(x.symbolize_keys) }
      end

      def self.find(id)
        data = BrickFTP::HTTPClient.new.get(api_path_for(:show, id))
        data.empty? ? nil : new(data.symbolize_keys)
      end

      def self.create(params = {})
        params.symbolize_keys!

        attributes = api_component_for(:create).except_path_and_query(params)
        data = BrickFTP::HTTPClient.new.post(api_path_for(:create, params), params: attributes)
        data = {} if data.is_a?(Array)
        new(data.symbolize_keys)
      end

      def initialize(params = {})
        params.each { |k, v| instance_variable_set(:"@#{k}", v) }
      end

      def update(params = {})
        params.symbolize_keys!

        attributes = self.class.api_component_for(:update).except_path_and_query(params)
        data = BrickFTP::HTTPClient.new.put(self.class.api_path_for(:update, self), params: attributes)
        data.each { |k, v| instance_variable_set(:"@#{k}", v) }

        self
      end

      def destroy
        BrickFTP::HTTPClient.new.delete(self.class.api_path_for(:delete, self))
        true
      end
    end
  end
end
