# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end
if ENV['CI'] && ENV['CODECOV_TOKEN']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'brick_ftp'
require 'webmock/rspec'

RSpec.configure do |config|
  config.before :each do
    BrickFTP.configure do |c|
      c.subdomain = 'koshigoe'
      c.api_key = nil
      c.session = nil
    end
  end
end
