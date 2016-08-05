# LogentriesPullApi

Ruby client for LogEntries Pull API.

For further details on the API itself please visit: https://logentries.com/doc/api-download/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'logentries_pull_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install logentries_pull_api

## Usage

```ruby
require 'logentries_pull_api'

client = LogentriesPullApi::Client.new 'my-4cc0unt-k3y', 'Some Log Set', 'Some Log'

all_messages = client.get

filtered_messages = client.get start: 1432080000000, end: 1432092600000, limit: 100, filter: '/some log message/i'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/BlasiusVonSzerencsi/logentries-pull-api-ruby.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

