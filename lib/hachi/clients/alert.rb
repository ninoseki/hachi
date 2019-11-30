# frozen_string_literal: true

require "date"
require "securerandom"

module Hachi
  module Clients
    class Alert < Base
      #
      # List alerts
      #
      # @return [Array]
      #
      def list
        get("/api/alert") { |json| json }
      end

      #
      # Get an alert
      #
      # @param [String] id Alert ID
      #
      # @return [Hash]
      #
      def get_by_id(id)
        get("/api/alert/#{id}") { |json| json }
      end

      #
      # Delete an alert
      #
      # @param [String] id Alert ID
      #
      # @return [String]
      #
      def delete_by_id(id)
        delete("/api/alert/#{id}") { |json| json }
      end

      #
      # Create an alert
      #
      # @param [String] title
      # @param [String] description
      # @param [String, nil] severity
      # @param [String, nil] date
      # @param [String, nil] tags
      # @param [String, nil] tlp
      # @param [String, nil] status
      # @param [String, nil] type
      # @param [String, nil] source
      # @param [String, nil] source_ref
      # @param [String, nil] artifacts
      # @param [String, nil] follow
      #
      # @return [Hash]
      #
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

      #
      # Find alerts
      #
      # @param [Hash] attributes
      # @param [String] range
      # @param [String, nil] sort
      #
      # @return [Array]
      #
      def search(attributes, range: "all", sort: nil)
        _search("/api/alert/_search", attributes: attributes, range: range, sort: sort) { |json| json }
      end

      #
      # Mark an alert as read
      #
      # @param [String] id Alert ID
      #
      # @return [Hash]
      #
      def mark_as_read(id)
        post("/api/alert/#{id}/markAsRead") { |json| json }
      end

      #
      # Mark an alert as unread
      #
      # @param [String] id Alert ID
      #
      # @return [Hash] hash
      #
      def mark_as_unread(id)
        post("/api/alert/#{id}/markAsUnread") { |json| json }
      end

      #
      # Create a case from an alert
      #
      # @param [String] id Alert ID
      #
      # @return [Hash]
      #
      def promote_to_case(id)
        post("/api/alert/#{id}/createCase") { |json| json }
      end

      #
      # Merge an alert / alerts in a case
      #
      # @param [String, Array] *ids Alert ID(s)
      # @param [String] case_id Case ID
      #
      # @return [Hash]
      #
      def merge_into_case(*ids, case_id)
        params = {
          alertIds: ids.flatten,
          caseId: case_id
        }
        post("/api/alert/merge/_bulk", params) { |json| json }
      end

      #
      # Update an alert
      #
      # @param [String, nil] id
      # @param [String, nil] title
      # @param [String, nil] description
      # @param [String, nil] severity
      # @param [String, nil] tags
      # @param [String, nil] tlp
      # @param [String, nil] artifacts
      #
      # @return [Hash]
      #
      def update(id, title: nil, description: nil, severity: nil, tags: nil, tlp: nil, artifacts: nil)
        attributes = {
          title: title,
          description: description,
          severity: severity,
          tags: tags,
          tlp: tlp,
          artifacts: artifacts,
        }.compact
        patch("/api/alert/#{id}", attributes) { |json| json }
      end
    end
  end
end
