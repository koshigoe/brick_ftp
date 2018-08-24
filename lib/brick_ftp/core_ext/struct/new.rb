# frozen_string_literal: true

module BrickFTP
  module CoreExt
    module Struct
      module New
        def new(*args, keyword_init: false, &block)
          super(*args) do
            define_method(:initialize) { |**kwargs| super(*members.map { |k| kwargs[k] }) } if keyword_init
            class_eval(&block) if block
          end
        end
      end
    end
  end
end
