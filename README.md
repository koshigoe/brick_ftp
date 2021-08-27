[![CircleCI](https://circleci.com/gh/koshigoe/brick_ftp/tree/master.svg?style=svg)](https://circleci.com/gh/koshigoe/brick_ftp/tree/master)
[![Maintainability](https://api.codeclimate.com/v1/badges/b996c388d3d32b7ec953/maintainability)](https://codeclimate.com/github/koshigoe/brick_ftp/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/b996c388d3d32b7ec953/test_coverage)](https://codeclimate.com/github/koshigoe/brick_ftp/test_coverage)


Files.com (BrickFTP)
====

This is a [File.com (BrickFTP)](https://files.com/)'s _unofficial_ [RESTful API](https://developers.files.com/) Client.

**I recommend official SDK: [Files-com/files-sdk-ruby](https://github.com/Files-com/files-sdk-ruby)**


Installation
----

Add this line to your application's Gemfile:

```ruby
gem 'brick_ftp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brick_ftp


Usage
----

```
$ docker compose up -d
$ bin/console
> client = BrickFTP::Client.new(base_url: 'http://localhost:40410', api_key: 'dummy')
> client.list_users
```

### Environment Variables

Name                  | Description
--------------------- | -----------
`BRICK_FTP_SUBDOMAIN` | Default subdomain (deprecated)
`BRICK_FTP_BASE_URL`  | Base URL of Files.com's REST API (e.g. `https://{subdomain}.files.com/`)
`BRICK_FTP_API_KEY`   | Default API key


Development
----

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


Contributing
----

Bug reports and pull requests are welcome on GitHub at https://github.com/koshigoe/brick_ftp.

