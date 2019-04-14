# frozen_string_literal: true

$LOAD_PATH.unshift("#{__dir__}/../lib")

require "hachi"

api = Hachi::API.new

# list up cases
results = api.case.list
ids = results.map { |result| result.dig("id") }

ids.each do |id|
  kase = api.case.get_by_id(id)
  p kase
end
