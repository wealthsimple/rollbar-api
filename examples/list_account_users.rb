require "dotenv/load"
require "bundler/setup"
require "rollbar-api"

account_name = ENV["ROLLBAR_ACCOUNT_NAME"] or raise "Must specify ROLLBAR_ACCOUNT_NAME in .env"
account_access_token = ENV["ROLLBAR_ACCOUNT_ACCESS_TOKEN"] or raise "Must specify ROLLBAR_ACCOUNT_ACCESS_TOKEN in .env"

RollbarApi.logger = Logger.new(nil)

account = RollbarApi::Account.configure(account_name, account_access_token)

users = account.get("/api/1/users")
users.result.users.first(5).each do |user|
  p user
end
