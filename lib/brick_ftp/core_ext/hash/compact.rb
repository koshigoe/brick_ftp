# frozen_string_literal: true

module BrickFTP
  module CoreExt
    module Hash
      module Compact
        def compact
          select { |_, value| !value.nil? }
        end
      end
    end
  end
end
