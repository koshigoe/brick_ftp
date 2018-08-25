# frozen_string_literal: true

module BrickFTP
  module CoreExt
    module Hash
      autoload :Compact, 'brick_ftp/core_ext/hash/compact'
      autoload :SymbolizeKeys, 'brick_ftp/core_ext/hash/symbolize_keys'

      refine ::Hash do
        include(BrickFTP::CoreExt::Hash::Compact) unless ::Hash.instance_methods(false).include?(:compact)
        include(BrickFTP::CoreExt::Hash::SymbolizeKeys) unless ::Hash.instance_methods(false).include?(:symbolize_keys)
      end
    end
  end
end
