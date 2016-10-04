module BrickFTP
  module API
    class Error < StandardError
    end

    class NoSuchAPI < Error
    end

    class UndefinedAttributes < Error
      def initialize(undefined_attributes = [])
        super "No such attributes: #{undefined_attributes.join(', ')}"
      end
    end
  end
end
