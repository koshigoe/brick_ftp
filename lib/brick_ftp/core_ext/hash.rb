# frozen_string_literal: true

module BrickFTP
  module CoreExt
    module Hash
      autoload :Compact, 'brick_ftp/core_ext/hash/compact'

      refine ::Hash do
        include(BrickFTP::CoreExt::Hash::Compact) unless ::Hash.instance_methods(false).include?(:compact)
      end
    end
  end
end
