# frozen_string_literal: true

$LOAD_PATH.unshift("#{__dir__}/../lib")

require "hachi"

def api
  @api ||= Hachi::API.new
end

description = ARGV[0].to_s
case_id = ARGV[1].to_s

alerts = api.alert.search(description: description)
alert_ids = alerts.map { |alert| alert.dig "id" }

api.alert.merge_into_case(alert_ids, case_id)
