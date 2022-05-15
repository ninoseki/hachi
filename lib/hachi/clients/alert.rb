# frozen_string_literal: true

require "date"
require "securerandom"

module Hachi
  module Clients
    class Alert < Base
      #
      # Get an alert
      #
      # @param [String] id Alert ID
      #
      # @return [Hash]
      #
      def get_by_id(id)
        get("/alert/#{id}") { |json| json }
      end

      #
      # Delete an alert
      #
      # @param [String] id Alert ID
      #
      # @return [String]
      #
      def delete_by_id(id)
        delete("/alert/#{id}") { |json| json }
      end

      #
      # Create an alert
      #
      # @param [Hash] payload
      #
      # @return [Hash]
      #
      def create(**payload)
        post("/alert", json: payload) { |json| json }
      end

      # Update an alert
      #
      # @param [String] id
      # @param [Hash] payload
      #
      # @return [Hash]
      #
      def update(id, **payload)
        patch("/alert/#{id}", json: payload) { |json| json }
      end
    end
  end
end
