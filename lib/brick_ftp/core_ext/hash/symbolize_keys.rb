# frozen_string_literal: true

module BrickFTP
  module CoreExt
    module Hash
      module SymbolizeKeys
        def symbolize_keys
          each_key.each_with_object({}) do |key, mem|
            symbolized_key = begin
                               key.to_sym
                             rescue StandardError
                               key
                             end
            mem[symbolized_key] = self[key]
          end
        end
      end
    end
  end
end
