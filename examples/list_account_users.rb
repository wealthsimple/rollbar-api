# frozen_string_literal: true

require 'dotenv/load'
require 'bundler/setup'
require 'rollbar_api'

account_name = ENV['ROLLBAR_ACCOUNT_NAME']
raise 'must specify ROLLBAR_ACCOUNT_NAME in .env' if account_name.blank?

account_access_token = ENV['ROLLBAR_ACCOUNT_ACCESS_TOKEN']
raise 'Must specify ROLLBAR_ACCOUNT_ACCESS_TOKEN in .env' if account_access_token.blank?

RollbarApi.logger = Logger.new(nil)

account = RollbarApi::Account.configure(account_name, account_access_token)

users = account.get('/api/1/users')
users.result.users.first(5).each do |user|
  p user
end
