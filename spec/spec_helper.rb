$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
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
