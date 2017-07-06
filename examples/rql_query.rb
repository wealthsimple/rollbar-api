require "dotenv/load"
require "pp"
require "bundler/setup"
require "rollbar-api"

project_name = ENV["ROLLBAR_PROJECT_NAME"] or raise "Must specify ROLLBAR_PROJECT_NAME in .env"
project_access_token = ENV["ROLLBAR_PROJECT_ACCESS_TOKEN"] or raise "Must specify ROLLBAR_PROJECT_ACCESS_TOKEN in .env"

project = RollbarApi::Project.configure(project_name, project_access_token)

# Create the job
rql_job = project.post("/api/1/rql/jobs", {
  query_string: "select * from item_occurrence where item.counter=1",
})

# Fetch job status
rql_job = project.get("/api/1/rql/job/#{rql_job.result.id}")
pp rql_job

if rql_job.result.status == "success"
  # Print out succeeded job result
  pp project.get("/api/1/rql/job/#{rql_job.result.id}/result")
end
