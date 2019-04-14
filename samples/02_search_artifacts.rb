# frozen_string_literal: true

$LOAD_PATH.unshift("#{__dir__}/../lib")

require "hachi"

api = Hachi::API.new

# search artifacts
results = api.artifact.search(data: "1.1.1.1", data_type: "ip")
ids = results.map { |result| result.dig("id") }

ids.each do |id|
  artifact = api.artifact.get_by_id(id)
  p artifact
end
