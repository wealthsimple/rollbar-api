# RollbarApi

Rubygem for read access to Rollbar REST and RQL APIs.

## Installation

First, generate read-only project access tokens for each project at:

https://rollbar.com/YOUR_ACCOUNT/YOUR_PROJECT/settings/access_tokens/

Next, add this line to your application's Gemfile and run `bundle` to install:

```ruby
gem 'rollbar_api'
```

Finally, configure it in an initializer with:

```
require 'rollbar_api'

ROLLBAR_PROJECT_1 = RollbarApi::Project.new("project-1-access-token")
ROLLBAR_PROJECT_2 = RollbarApi::Project.new("project-2-access-token")
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
