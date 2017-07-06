require "dotenv/load"
require "pp"
require "bundler/setup"
require "rollbar-api"

account_name = ENV["ROLLBAR_ACCOUNT_NAME"] or raise "Must specify ROLLBAR_ACCOUNT_NAME in .env"
account_access_token = ENV["ROLLBAR_ACCOUNT_ACCESS_TOKEN"] or raise "Must specify ROLLBAR_ACCOUNT_ACCESS_TOKEN in .env"

RollbarApi::Account.configure(account_name, account_access_token)

users = RollbarApi::Account.find(account_name).get("/api/1/users")
users.result.users.each do |user|
  p [user.username, user.email]
end
