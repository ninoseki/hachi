# frozen_string_literal: true

module Hachi
  module Clients
    class Case < Base
      #
      # List cases
      #
      # @return [Array]
      #
      def list
        get("/api/case") { |json| json }
      end

      #
      # Get a case
      #
      # @param [String] id Case ID
      #
      # @return [Hash]
      #
      def get_by_id(id)
        get("/api/case/#{id}") { |json| json }
      end

      #
      # Delete a case
      #
      # @param [String] id Case ID
      #
      # @return [String]
      #
      def delete_by_id(id)
        delete("/api/case/#{id}") { |json| json }
      end

      #
      # Create a case
      #
      # @param [String, nil] title
      # @param [String, nil] description
      # @param [Integer, nil] severity
      # @param [String, nil] start_date
      # @param [String, nil] owner
      # @param [Boolean, nil] flag
      # @param [Intege, nil] tlp
      # @param [String, nil] tags
      #
      # @return [Hash]
      #
      def create(title:, description:, severity: nil, start_date: nil, owner: nil, flag: nil, tlp: nil, tags: nil)
        kase = Models::Case.new(
          title: title,
          description: description,
          severity: severity,
          start_date: start_date,
          owner: owner,
          flag: flag,
          tlp: tlp,
          tags: tags,
        )

        post("/api/case", kase.payload) { |json| json }
      end

      #
      # Find cases
      #
      # @param [Hash] attributes
      # @param [String] range
      #
      # @return [Hash]
      #
      def search(range: "all", **attributes)
        _search("/api/case/_search", attributes: attributes, range: range) { |json| json }
      end

      #
      # Get list of cases linked to this case
      #
      # @param [String] id Case ID
      #
      # @return [Array]
      #
      def links(id)
        get("/api/case/#{id}/links") { |json| json }
      end

      #
      # Merge two cases
      #
      # @param [String] id1 Case ID
      # @param [String] id2 Case ID
      #
      # @return [Hash]
      #
      def merge(id1, id2)
        post("/api/case/#{id1}/_merge/#{id2}") { |json| json }
      end

      #
      # Update a case
      #
      # @param [String, nil] id
      # @param [String, nil] title
      # @param [String, nil] description
      # @param [String, nil] severity
      # @param [String, nil] start_date
      # @param [String, nil] owner
      # @param [Boolean, nil] flag
      # @param [Integer, nil] tlp
      # @param [String, nil] tags
      # @param [String, nil] status
      # @param [String, nil] resolution_status
      # @param [String, nil] impact_status
      # @param [String, nil] summary
      # @param [String, nil] end_date
      # @param [String, nil] metrics
      # @param [String, nil] custom_fields
      #
      # @return [Hash]
      #
      def update(id, title: nil, description: nil, severity: nil, start_date: nil, owner: nil, flag: nil, tlp: nil, tags: nil, status: nil, resolution_status: nil, impact_status: nil, summary: nil, end_date: nil, metrics: nil, custom_fields: nil )
        attributes = {
          title: title,
          description: description,
          severity: severity,
          startDate: start_date,
          owner: owner,
          flag: flag,
          tlp: tlp,
          tags: tags,
          status: status,
          resolutionStatus: resolution_status,
          impactStatus: impact_status,
          summary: summary,
          endDate: end_date,
          metrics: metrics,
          customFields: custom_fields
        }.compact
        patch("/api/case/#{id}", attributes) { |json| json }
      end
    end
  end
end
