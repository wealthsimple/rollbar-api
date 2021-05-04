# frozen_string_literal: true

require 'dotenv/load'
require 'bundler/setup'
require 'rollbar_api'

project_name = ENV['ROLLBAR_PROJECT_NAME']
project_access_token = ENV['ROLLBAR_PROJECT_ACCESS_TOKEN']

raise 'Must specify ROLLBAR_PROJECT_NAME in .env' if project_PROJECT_NAME.blank?
raise 'Must specify ROLLBAR_ACCOUNT_ACCESS_TOKEN in .env' if project_access_token.blank?

project = RollbarApi::Project.configure(project_name, project_access_token)

top_active_items = project.get('/api/1/reports/top_active_items', {
  hours: '24',
  environments: 'production,staging',
})

top_active_items.result.first(5).each_with_index do |item, i|
  p i, item
  puts '=' * 80
end
