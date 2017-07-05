# rollbar_api [![CircleCI](https://circleci.com/gh/wealthsimple/rollbar_api.svg?style=svg)](https://circleci.com/gh/wealthsimple/rollbar_api)

Rubygem for accessing Rollbar's full REST and RQL APIs.

## Installation

First, generate read-only project access tokens for each project at:

https://rollbar.com/YOUR_ACCOUNT/YOUR_PROJECT/settings/access_tokens/

Next, add this line to your application's Gemfile and run `bundle` to install:

```ruby
gem 'rollbar_api'
```

## Usage

First, configure it in an initializer with:

```ruby
require 'rollbar_api'

# Add as many projects as you want
RollbarApi::Project.add("my-project", ENV["MY_PROJECT_ACCESS_TOKEN"])
RollbarApi::Project.add("other-project", ENV["OTHER_PROJECT_ACCESS_TOKEN"])
```

Next, you can fetch items, deploys, occurrences, on so on:

```ruby
items = RollbarApi::Project.find("my-project").get("/api/1/items/")
```

You can also run RQL queries:

```ruby
# Create a job
rql_job = RollbarApi::Project.find("my-project").post("/api/1/rql/jobs", {
  query_string: "select * from item_occurrence where item.counter=1",
})

# Check its status
rql_job = RollbarApi::Project.find("my-project").get("/api/1/rql/job/#{rql_job.result.id}")

# If it succeeded, get the RQL result
if rql_job.result.status == "success"
  rql_result = RollbarApi::Project.find("wealthsimple").get("/api/1/rql/job/#{rql_job.result.id}/result")
  p rql_result
end
```

See https://rollbar.com/docs/api/ for a full reference of API requests and responses.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
