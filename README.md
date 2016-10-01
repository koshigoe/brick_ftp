[![CircleCI](https://circleci.com/gh/koshigoe/brick_ftp/tree/master.svg?style=svg)](https://circleci.com/gh/koshigoe/brick_ftp/tree/master)

# BrickFTP

This is a [BrickFTP](https://brickftp.com/)'s _unofficial_ [REST API](https://brickftp.com/ja/docs/rest-api/) Client.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'brick_ftp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brick_ftp

## Usage

### Configuration

```ruby
BrickFTP.configure do |c|
  c.subdomain = 'koshigoe'      # Used by build API URL(e.g. https://{subdomain}.brickftp.com/api/rest/v1/...)
  c.api_key = 'xxxxx'           # Used by set REST API key.
  c.logger = Logger.new(STDOUT) # Used by logging.
end
```

- Environment value `BRICK_FTP_SUBDOMAIN` is set to `subdomain`.
- Environment value `BRICK_FTP_API_KEY` is set to `api_key`.

### Authentication

If you authenticate by API key, you set API key to configuration.
If you authenticate by session cooki, you must authenticate by API.

```ruby
# Authenticate and set authentication session to configuration.
BrickFTP::API::Authentication.login('koshigoe', 'password')
```

### Other APIs

see API document or source code.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/brick_ftp.

