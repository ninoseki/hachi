# frozen_string_literal: true

module Hachi
  module Clients
    class Artifact < Base
      #
      # Create an artifact
      #
      # @param [String] case_id Artifact ID
      # @param [String] data
      # @param [String] data_type
      # @param [String, nil] message
      # @param [Integer, nil] tlp
      # @param [Array<String>, nil] tags
      #
      # @return [Hash]
      #
      def create(case_id, data:, data_type:, message: nil, tlp: nil, tags: nil)
        artifact = Models::Artifact.new(
          data: data,
          data_type: data_type,
          message: message,
          tlp: tlp,
          tags: tags,
        )

        post("/api/case/#{case_id}/artifact", artifact.payload) { |json| json }
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

      #
      # Find artifacts
      #
      # @param [Hash] attributes
      # @param [String] range
      #
      # @return [Array]
      #
      def search( range: "all", **attributes)
        _search("/api/case/artifact/_search", attributes: attributes, range: range) { |json| json }
      end

      #
      # Get list of similar observables
      #
      # @param [String] id Artifact ID
      #
      # @return [Array]
      #
      def similar(id)
        get("/api/case/artifact/#{id}/similar") { |json| json }
      end
    end
  end
end
