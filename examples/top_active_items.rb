require "dotenv/load"
require "pp"
require "bundler/setup"
require "rollbar-api"

project_name = ENV["ROLLBAR_PROJECT_NAME"] or raise "Must specify ROLLBAR_PROJECT_NAME in .env"
project_access_token = ENV["ROLLBAR_PROJECT_ACCESS_TOKEN"] or raise "Must specify ROLLBAR_PROJECT_ACCESS_TOKEN in .env"

project = RollbarApi::Project.configure(project_name, project_access_token)

top_active_items = project.get("/api/1/reports/top_active_items", {
  hours: "24",
  environments: "production,staging",
})

top_active_items.result.each_with_index do |item, i|
  pp i, item
  puts "=" * 80
end
