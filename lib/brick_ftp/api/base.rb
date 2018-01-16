require 'cgi'

module BrickFTP
  module API
    class Base
      def self.inherited(subclass)
        subclass.include APIDefinition
      end

      def self.all(params = {})
        params.symbolize_keys!

        data = BrickFTP::HTTPClient.new.send(
          endpoints[:index][:http_method],
          api_path_for(:index, params),
          params: api_component_for(:index).except_path_and_query(params)
        )
        data.map { |x| new(x.symbolize_keys) }
      end

      def self.find(id, params: {})
        data = BrickFTP::HTTPClient.new.send(
          endpoints[:show][:http_method],
          api_path_for(:show, id),
          params: params
        )
        data.empty? ? nil : new(data.symbolize_keys)
      end

      def self.create(params = {})
        params.symbolize_keys!

        data = BrickFTP::HTTPClient.new.send(
          endpoints[:create][:http_method],
          api_path_for(:create, params),
          params: api_component_for(:create).except_path_and_query(params)
        )
        data = {} if data.is_a?(Array)
        new(data.symbolize_keys)
      end

      # @return [Hash{String => Object}] Key Value pairs of API properties
      attr_reader :properties

      def initialize(params = {})
        @properties = {}
        params.each { |k, v| write_property(k, v) }
      end

      def update(params = {})
        params.symbolize_keys!

        data = BrickFTP::HTTPClient.new.send(
          self.class.endpoints[:update][:http_method],
          self.class.api_path_for(:update, self),
          params: self.class.api_component_for(:update).except_path_and_query(params)
        )
        data.each { |k, v| write_property(k, v) }

        self
      end

      def destroy(recursive: false)
        headers = {}
        headers['Depth'] = 'infinity' if recursive

        BrickFTP::HTTPClient.new.send(
          self.class.endpoints[:delete][:http_method],
          self.class.api_path_for(:delete, self),
          headers: headers
        )
        true
      end

      def as_json
        self.class.attributes.each_with_object({}) { |name, res| res[name] = read_property(name) }
      end

      def to_json
        as_json.to_json
      end

      def write_property(key, value)
        properties[key.to_s] = value
      end

      def read_property(key)
        properties[key.to_s]
      end

      def delete_property(key)
        properties.delete(key.to_s)
      end

      private

      def respond_to_missing?(method_name, _include_private)
        self.class.attributes.include?(method_name.to_sym)
      end

      def method_missing(method_name, *args)
        super unless self.class.attributes.include?(method_name.to_sym)

        read_property(method_name)
      end
    end
  end
end
