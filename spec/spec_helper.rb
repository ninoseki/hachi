# frozen_string_literal: true

require "bundler/setup"

require "simplecov"
require "coveralls"
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter "/spec"
end
Coveralls.wear!

require "vcr"

require "hachi"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

API_KEY_NAME = "THEHIVE_API_KEY"
API_ENDPOINT_KEY_NAME = "THEHIVE_API_ENDPOINT"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.configure_rspec_metadata!
  config.hook_into :webmock
  config.ignore_localhost = false

  ENV[API_KEY_NAME] = "dummy" unless ENV.key?(API_KEY_NAME)
  config.filter_sensitive_data("<API_KEY>") { ENV[API_KEY_NAME] }

  ENV[API_ENDPOINT_KEY_NAME] = "http://dummy.example.com:9000" unless ENV.key?(API_ENDPOINT_KEY_NAME)

  uri = URI(ENV[API_ENDPOINT_KEY_NAME])
  config.filter_sensitive_data("<API_ENDPOINT>") { uri.hostname }
end
