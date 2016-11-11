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

      def initialize(params = {})
        params.each { |k, v| instance_variable_set(:"@#{k}", v) }
      end

      def update(params = {})
        params.symbolize_keys!

        data = BrickFTP::HTTPClient.new.send(
          self.class.endpoints[:update][:http_method],
          self.class.api_path_for(:update, self),
          params: self.class.api_component_for(:update).except_path_and_query(params)
        )
        data.each { |k, v| instance_variable_set(:"@#{k}", v) }

        self
      end

      def destroy(recursive: false)
        headers = {}
        headers['Depth'] = 'infinity' if recursive

        BrickFTP::HTTPClient.new.send(
          self.class.endpoints[:delete][:http_method],
          self.class.api_path_for(:delete, self),
          headers: headers,
        )
        true
      end

      def as_json
        self.class.attributes.each_with_object({}) { |name, res| res[name] = send(name) }
      end

      def to_json
        as_json.to_json
      end
    end
  end
end
