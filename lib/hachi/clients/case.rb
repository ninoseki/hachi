# frozen_string_literal: true

module Hachi
  module Clients
    class Case < Base
      #
      # Get a case
      #
      # @param [String] id Case ID
      #
      # @return [Hash]
      #
      def get_by_id(id)
        get("/case/#{id}") { |json| json }
      end

      #
      # Delete a case
      #
      # @param [String] id Case ID
      #
      # @return [String]
      #
      def delete_by_id(id)
        delete("/case/#{id}") { |json| json }
      end

      #
      # Create a case
      #
      # @param [Hash] payload
      #
      # @return [Hash]
      #
      def create(**payload)
        post("/case", json: payload) { |json| json }
      end

      #
      # Update a case
      #
      # @param [String] id
      # @param [Hash] payload
      #
      # @return [Hash]
      #
      def update(id, **payload)
        patch("/case/#{id}", json: payload) { |json| json }
      end
    end
  end
end
