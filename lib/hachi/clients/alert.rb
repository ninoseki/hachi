# frozen_string_literal: true

require "date"
require "securerandom"

module Hachi
  module Clients
    class Alert < Base
      def list
        get("/api/alert") { |json| json }
      end

      def get_by_id(id)
        get("/api/alert/#{id}") { |json| json }
      end

      def delete_by_id(id)
        delete("/api/alert/#{id}") { |json| json }
      end

      def create(title:, description:, severity: nil, date: nil, tags: nil, tlp: nil, status: nil, type:, source:, source_ref: nil, artifacts: nil, follow: nil)
        alert = Models::Alert.new(
          title: title,
          description: description,
          severity: severity,
          date: date,
          tags: tags,
          tlp: tlp,
          status: status,
          type: type,
          source: source,
          source_ref: source_ref,
          artifacts: artifacts,
          follow: follow,
        )
        post("/api/alert", alert.payload) { |json| json }
      end

      def search(attributes, range: "all", sort: nil)
        _search("/api/alert/_search", attributes: attributes, range: range, sort: sort) { |json| json }
      end
    end
  end
end
