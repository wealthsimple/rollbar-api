# frozen_string_literal: true

require 'dotenv/load'
require 'bundler/setup'
require 'rollbar_api'

project_name = ENV['ROLLBAR_PROJECT_NAME']
project_access_token = ENV['ROLLBAR_PROJECT_ACCESS_TOKEN']

raise 'Must specify ROLLBAR_PROJECT_NAME in .env' if project_name.blank?
raise 'Must specify ROLLBAR_ACCOUNT_ACCESS_TOKEN in .env' if project_access_token.blank?

project = RollbarApi::Project.configure(project_name, project_access_token)

# Create the job
rql_job = project.post('/api/1/rql/jobs', {
  query_string: 'select * from item_occurrence where item.counter=1',
})

# Fetch job status
rql_job = project.get("/api/1/rql/job/#{rql_job.result.id}")
p rql_job

if rql_job.result.status == 'success'
  # Print out succeeded job result
  p project.get("/api/1/rql/job/#{rql_job.result.id}/result")
end
