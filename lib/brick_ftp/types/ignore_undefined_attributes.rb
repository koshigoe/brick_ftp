# frozen_string_literal: true

module BrickFTP
  module Types
    module IgnoreUndefinedAttributes
      def initialize(**kwargs)
        super(**members.each_with_object({}) { |k, m| m[k] = kwargs[k] })
      end
    end
  end
end
