# frozen_string_literal: true

module Hachi
  module Clients
    class Observable < Base
      #
      # Create an observable in a case
      #
      # @param [String] case_id Observable ID
      # @param [Hash] payload
      #
      # @return [Hash]
      #
      def create_in_case(case_id, **payload)
        post("/case/#{case_id}/observable", json: payload) { |json| json }
      end

      #
      # Create an observable in an alert
      #
      # @param [String] alert_id Observable ID
      # @param [Hash] payload
      #
      # @return [Hash]
      #
      def create_in_alert(alert_id, **payload)
        post("/alert/#{alert_id}/observable", json: payload) { |json| json }
      end

      #
      # Get an observable
      #
      # @param [String] id observable ID
      #
      # @return [Hash]
      #
      def get_by_id(id)
        get("/observable/#{id}") { |json| json }
      end

      #
      # Delete an observable
      #
      # @param [String] id observable ID
      #
      # @return [String]
      #
      def delete_by_id(id)
        delete("/observable/#{id}") { |json| json }
      end
    end
  end
end
