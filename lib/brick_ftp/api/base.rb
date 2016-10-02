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
          @api = {}
          @writable_attributes = []
          @readonly_attributes = []
        end
      end

      class << self
        attr_reader :writable_attributes, :readonly_attributes
      end

      def self.attributes
        writable_attributes + readonly_attributes
      end

      def self.define_api(method, path)
        @api[method] = path
      end

      def self.define_writable_attributes(*attributes)
        @writable_attributes = attributes
        attr_reader *@writable_attributes
      end

      def self.define_readonly_attributes(*attributes)
        @readonly_attributes = attributes
        attr_reader *@readonly_attributes
      end

      def self.api_path_for(method, params = {})
        raise NoSuchAPIError, "#{method} #{self.name}" unless @api.key?(method)
        @api[method] % Hash[params.map { |k, v| [k, CGI.escape(v.to_s)] }]
      end

      QUERY_PARAMS = %i(page per_page start_at recursive).freeze

      def self.all(path_params = {})
        path_params.symbolize_keys!
        query_params = QUERY_PARAMS.each_with_object({}) do |name, res|
          res.update(name => path_params.delete(name)) if path_params.key?(name)
        end

        path = api_path_for(:index, path_params)
        unless query_params.empty?
          query = query_params.each_with_object([]) do |(k, v), res|
            res << "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"
          end.join('&')
          path = "#{path}?#{query}"
        end

        BrickFTP::HTTPClient.new.get(path).map { |x| new(x.symbolize_keys) }
      end

      def self.find(id)
        data = BrickFTP::HTTPClient.new.get(api_path_for(:show, id: id))
        data.empty? ? nil : new(data.symbolize_keys)
      end

      def self.create(params = {}, path_params = {})
        params.symbolize_keys!
        undefined_attributes = params.keys - writable_attributes
        raise UndefinedAttributesError, undefined_attributes unless undefined_attributes.empty?

        data = BrickFTP::HTTPClient.new.post(api_path_for(:create, path_params), params: params)
        new(data.symbolize_keys)
      end

      def initialize(params = {})
        undefined_attributes = params.keys - self.class.attributes
        raise UndefinedAttributesError, undefined_attributes unless undefined_attributes.empty?

        params.each { |k, v| instance_variable_set(:"@#{k}", v) }
      end

      def update(params = {})
        params.symbolize_keys!
        undefined_attributes = params.keys - self.class.writable_attributes
        raise UndefinedAttributesError, undefined_attributes unless undefined_attributes.empty?

        data = BrickFTP::HTTPClient.new.put(self.class.api_path_for(:update, id: id), params: params)
        data.each { |k, v| instance_variable_set(:"@#{k}", v) }

        self
      end

      def destroy
        BrickFTP::HTTPClient.new.delete(self.class.api_path_for(:delete, id: id))
        true
      end
    end
  end
end
