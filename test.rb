require "dotenv/load"
require "pp"
require "bundler/setup"
require "rollbar-api"

RollbarApi::Project.add("wealthsimple", ENV["ROLLBAR_WEALTHSIMPLE_ACCESS_TOKEN"])

items = RollbarApi::Project.find("wealthsimple").get("/api/1/items")
items.result.items.first(5).each do |item|
  p item
  puts "=" * 80
end

# https://rollbar.com/item/455861389/instance/26697569007/
pp RollbarApi::Project.find("wealthsimple").get("/api/1/item/455861389")

rql_job = RollbarApi::Project.find("wealthsimple").post("/api/1/rql/jobs", {
  query_string: "select * from item_occurrence where item.counter=1",
})

rql_job = RollbarApi::Project.find("wealthsimple").get("/api/1/rql/job/#{rql_job.result.id}")
pp rql_job

if rql_job.result.status == "success"
  pp RollbarApi::Project.find("wealthsimple").get("/api/1/rql/job/#{rql_job.result.id}/result")
end
