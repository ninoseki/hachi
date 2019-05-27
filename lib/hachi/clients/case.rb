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
    end
  end
end
