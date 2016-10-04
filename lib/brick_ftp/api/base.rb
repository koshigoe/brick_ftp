require 'cgi'

module BrickFTP
  module API
    class Base
      def self.inherited(subclass)
        subclass.include APIDefinition
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
