# frozen_string_literal: true

Warning[:deprecated] = true if Warning.respond_to?(:[]=)

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'brick_ftp'
require 'webmock/rspec'
