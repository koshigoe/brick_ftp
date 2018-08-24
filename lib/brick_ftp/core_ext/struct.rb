# frozen_string_literal: true

module BrickFTP
  module CoreExt
    module Struct
      autoload :New, 'brick_ftp/core_ext/struct/new'

      refine ::Struct do
        ::Struct.singleton_class.prepend(BrickFTP::CoreExt::Struct::New) if RUBY_VERSION < '2.5.0'
      end
    end
  end
end
