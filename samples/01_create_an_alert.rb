# frozen_string_literal: true

$LOAD_PATH.unshift("#{__dir__}/../lib")

require "hachi"

api = Hachi::API.new

# create a simple alert
api.alert.create(title: "test", description: "test", type: "test", source: "test")

# create an alert with artifacts
artifacts = [
  { data: "1.1.1.1", data_type: "ip", message: "test" },
  { data: "github.com", data_type: "domain", tags: ["test"] }
]
api.alert.create(title: "test", description: "test", type: "test", source: "test", artifacts: artifacts)
