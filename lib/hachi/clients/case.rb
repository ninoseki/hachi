# frozen_string_literal: true

module Hachi
  module Clients
    class Case < Base
      def list
        get("/api/case") { |json| json }
      end

      def get_by_id(id)
        get("/api/case/#{id}") { |json| json }
      end

      def delete_by_id(id)
        delete("/api/case/#{id}") { |json| json }
      end

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

      def search(attributes, range: "all")
        _search("/api/case/_search", attributes: attributes, range: range) { |json| json }
      end

      def links(id)
        get("/api/case/#{id}/links") { |json| json }
      end

      def merge(id1, id2)
        post("/api/case/#{id1}/_merge/#{id2}") { |json| json }
      end

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
