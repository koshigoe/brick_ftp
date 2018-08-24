[![CircleCI](https://circleci.com/gh/koshigoe/brick_ftp/tree/master.svg?style=svg)](https://circleci.com/gh/koshigoe/brick_ftp/tree/master)
[![codecov](https://codecov.io/gh/koshigoe/brick_ftp/branch/master/graph/badge.svg)](https://codecov.io/gh/koshigoe/brick_ftp)


BrickFTP
====

This is a [BrickFTP](https://brickftp.com/)'s _unofficial_ [RESTful API](https://developers.brickftp.com/) Client.


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
$ bin/console
> client = BrickFTP::Client.new
> client.list_users
```

```
$ bin/console
> api_client = BrickFTP::RESTfulAPI::Client.new(ENV['BRICK_FTP_SUBDOMAIN'], ENV['BRICK_FTP_API_KEY'])
> BrickFTP::RESTfulAPI::ListUsers.new(api_client).call
```

### Environment Variables

Name                  | Description
--------------------- | -----------
`BRICK_FTP_SUBDOMAIN` | Overwrite default subdomain
`BRICK_FTP_API_KEY`   | Overwrite default API key


Development
----

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


Contributing
----

Bug reports and pull requests are welcome on GitHub at https://github.com/koshigoe/brick_ftp.

