require "dotenv/load"
require "pp"
require "bundler/setup"
require "rollbar_api"

RollbarApi::Project.add("wealthsimple", ENV["ROLLBAR_WEALTHSIMPLE_ACCESS_TOKEN"])

# https://rollbar.com/item/455861389/instance/26697569007/
pp RollbarApi::Project.find("wealthsimple").get("/api/1/item/455861389")
