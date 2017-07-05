require "bundler/setup"
require "rollbar_api"
require "rspec/collection_matchers"
require "webmock/rspec"
require "rspec/its"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.after(:each) do
    RollbarApi::Project.delete_all
  end
end
