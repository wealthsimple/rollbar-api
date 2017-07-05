require "dotenv/load"
require "pp"
require "bundler/setup"
require "rollbar_api"

RollbarApi::Project.add("wealthsimple", ENV["ROLLBAR_WEALTHSIMPLE_ACCESS_TOKEN"])

# https://rollbar.com/item/455861389/instance/26697569007/
pp RollbarApi::Project.find("wealthsimple").get("/api/1/item/455861389")

rql_job = RollbarApi::Project.find("wealthsimple").post("/api/1/rql/jobs", {
  query_string: "select * from item_occurrence where item.counter=1",
})

pp RollbarApi::Project.find("wealthsimple").get("/api/1/rql/job/#{rql_job.result.id}")
