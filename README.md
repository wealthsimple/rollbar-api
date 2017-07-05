# rollbar-api [![CircleCI](https://circleci.com/gh/wealthsimple/rollbar-api.svg?style=svg)](https://circleci.com/gh/wealthsimple/rollbar-api) [![](https://img.shields.io/gem/v/rollbar-api.svg)](https://rubygems.org/gems/rollbar-api)

Rubygem for accessing Rollbar's full REST and RQL APIs.

## Installation

Add this line to your application's Gemfile and run `bundle` to install:

```ruby
gem 'rollbar-api'
```

## Usage

First, generate read-only access tokens for each project you need access to by navigating to **Settings** > **Project Access Tokens** and clicking **Add new access token**.

Next, configure each project:

```ruby
# config/initializers/rollbar-api.rb in a Rails project
require 'rollbar-api'

# Add as many projects as you need. Each should have a unique access token.
RollbarApi::Project.configure("my-project", ENV["MY_PROJECT_ACCESS_TOKEN"])
RollbarApi::Project.configure("other-project", ENV["OTHER_PROJECT_ACCESS_TOKEN"])
```

### REST API

You can make HTTP `GET` calls to fetch items, deploys, occurrences, and so on by finding any project you added in the configuration and calling `.get` with the API endpoint:

```ruby
items = RollbarApi::Project.find("my-project").get("/api/1/items/")
```

Specify query parameters by passing them in as a hash:

```ruby
top_items = RollbarApi::Project.find("my-project").get("/api/1/reports/top_active_items", {
  hours: "24",
  environments: "production,staging",
})
```

### RQL Queries

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
  rql_result = RollbarApi::Project.find("my-project").get("/api/1/rql/job/#{rql_job.result.id}/result")
  p rql_result
end
```

See https://rollbar.com/docs/api/ for a full reference of API requests and responses.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
