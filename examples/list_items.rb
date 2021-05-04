# frozen_string_literal: true

require 'dotenv/load'
require 'bundler/setup'
require 'rollbar_api'

project_name = ENV['ROLLBAR_PROJECT_NAME']
project_access_token = ENV['ROLLBAR_PROJECT_ACCESS_TOKEN']

raise 'Must specify ROLLBAR_PROJECT_NAME in .env' if project_name.blank?
raise 'Must specify ROLLBAR_ACCOUNT_ACCESS_TOKEN in .env' if project_access_token.blank?

project = RollbarApi::Project.configure(project_name, project_access_token)

# Fetch all items
items = project.get('/api/1/items')

# Print out the first 5 items
items.result.items.first(5).each do |item|
  p item
  puts '=' * 80
end
