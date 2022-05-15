# frozen_string_literal: true

module Hachi
  module Clients
    class Artifact < Base
      #
      # Create an artifact
      #
      # @param [String] case_id Artifact ID
      # @param [Hash] payload
      #
      # @return [Hash]
      #
      def create(case_id, **payload)
        post("/api/case/#{case_id}/artifact", json: payload) { |json| json }
      end

      #
      # Get an artifact
      #
      # @param [String] id Artifact ID
      #
      # @return [Hash]
      #
      def get_by_id(id)
        get("/api/case/artifact/#{id}") { |json| json }
      end

      #
      # Delete an artifact
      #
      # @param [String] id Artifact ID
      #
      # @return [String]
      #
      def delete_by_id(id)
        delete("/api/case/artifact/#{id}") { |json| json }
      end
    end
  end
end
