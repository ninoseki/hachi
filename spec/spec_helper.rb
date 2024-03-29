# frozen_string_literal: true

require "bundler/setup"

require "simplecov"

class InceptionFormatter
  def format(result)
    Coveralls::SimpleCov::Formatter.new.format(result)
  end
end

def setup_formatter
  if ENV["GITHUB_ACTIONS"]
    require "simplecov-lcov"

    SimpleCov::Formatter::LcovFormatter.config do |c|
      c.report_with_single_file = true
      c.single_report_path = "coverage/lcov.info"
    end
  end

  SimpleCov.formatter =
    if ENV.fetch("CI") { ENV.fetch("COVERALLS_REPO_TOKEN", nil) }
      if ENV["GITHUB_ACTIONS"]
        SimpleCov::Formatter::MultiFormatter.new([InceptionFormatter, SimpleCov::Formatter::LcovFormatter])
      else
        InceptionFormatter
      end
    else
      SimpleCov::Formatter::HTMLFormatter
    end
end

setup_formatter

SimpleCov.start do
  add_filter do |source_file|
    source_file.filename.include?("spec") && !source_file.filename.include?("fixture")
  end
  add_filter %r{/.bundle/}
end

require "coveralls"

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
API_VERSION_KEY_NAME = "THEHIVE_API_VERSION"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.configure_rspec_metadata!
  config.hook_into :webmock
  config.ignore_localhost = false

  # set dummy API key
  ENV[API_KEY_NAME] = ENV.fetch(API_KEY_NAME, "dummy")
  config.filter_sensitive_data("<API_KEY>") { ENV.fetch(API_KEY_NAME, nil) }

  # set dummy API endoint
  ENV[API_ENDPOINT_KEY_NAME] = ENV.fetch(API_ENDPOINT_KEY_NAME, "http://dummy.example.com:9000")

  uri = URI(ENV.fetch(API_ENDPOINT_KEY_NAME, nil))
  config.filter_sensitive_data("<API_ENDPOINT>") { uri.hostname }

  # set dummy API version
  ENV[API_VERSION_KEY_NAME] = ENV.fetch(API_VERSION_KEY_NAME, "v1")
end
