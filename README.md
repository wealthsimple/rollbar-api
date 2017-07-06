# rollbar-api [![CircleCI](https://circleci.com/gh/wealthsimple/rollbar-api.svg?style=svg)](https://circleci.com/gh/wealthsimple/rollbar-api) [![](https://img.shields.io/gem/v/rollbar-api.svg)](https://rubygems.org/gems/rollbar-api)

Rubygem for accessing Rollbar's full REST and RQL APIs.

The [official rollbar rubygem](https://github.com/rollbar/rollbar-gem) only covers a small portion of the API, whereas this rubygem provides an interface over all API endpoints, including the Rollbar Query Language (RQL) endpoints.

This gem aims to be future-compatible by not hard-coding any endpoints or request structures. See https://rollbar.com/docs/api/ for a full reference of all API requests and responses.

## Installation

Add this line to your application's Gemfile and run `bundle` to install:

```ruby
gem 'rollbar-api'
```

## Usage (Project-level APIs)

First, generate access tokens for each project you need access to by navigating to **Settings** > **Project Access Tokens** and clicking **Add new access token**. Unless you specifically need write access, it is recommended that you generate a read-only token.

Next, configure each project:

```ruby
# config/initializers/rollbar-api.rb in a Rails project
require 'rollbar-api'

# Add as many projects as you need. Each should have a unique access token.
RollbarApi::Project.configure("my-project", ENV["MY_PROJECT_ACCESS_TOKEN"])
RollbarApi::Project.configure("other-project", ENV["OTHER_PROJECT_ACCESS_TOKEN"])
```

### Making API Requests

You can make HTTP `GET` calls to fetch items, deploys, occurrences, and so on by finding any project you added in the configuration and calling `.get` with the API endpoint:

```ruby
project = RollbarApi::Project.find("my-project")
items = project.get("/api/1/items/")
```

Specify query parameters by passing them in as a hash:

```ruby
project = RollbarApi::Project.find("my-project")
top_items = project.get("/api/1/reports/top_active_items", {
  hours: "24",
  environments: "production,staging",
})
```

If you need to make an HTTP `POST`, `DELETE`, and so on, just replace `.get` with `.post`, `.delete`, and so forth.

### RQL Queries

You can also run RQL queries:

```ruby
# Create a job
project = RollbarApi::Project.find("my-project")
rql_job = project.post("/api/1/rql/jobs", {
  query_string: "select * from item_occurrence where item.counter=1",
})

# Check its status
rql_job = project.get("/api/1/rql/job/#{rql_job.result.id}")

# If it succeeded, get the RQL result
if rql_job.result.status == "success"
  rql_result = project.get("/api/1/rql/job/#{rql_job.result.id}/result")
  p rql_result
end
```

## Usage (Account-level APIs)

First, generate access tokens for each account you need access to by navigating to https://rollbar.com/settings/accounts/ACCOUNT_NAME/access_tokens/ and clicking **Add new access token**. Unless you specifically need write access, it is recommended that you generate a read-only token.

Next, configure each account:

```ruby
# config/initializers/rollbar-api.rb in a Rails project
require 'rollbar-api'

# Add as many accounts as you need (normally just one). Each should have a unique access token.
RollbarApi::Account.configure("my-organization", ENV["ROLLBAR_ACCOUNT_ACCESS_TOKEN"])
```

### Making API Requests

Making API requests through Account-level APIs works similarly to project-level API. Here's an example that fetches all Rollbar user details for your account:

```ruby
account = RollbarApi::Account.find("my-organization")
users = account.get("/api/1/users")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
