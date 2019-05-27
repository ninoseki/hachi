# frozen_string_literal: true

module Hachi
  module Clients
    class Artifact < Base
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

      def get_by_id(id)
        get("/api/case/artifact/#{id}") { |json| json }
      end

      def delete_by_id(id)
        delete("/api/case/artifact/#{id}") { |json| json }
      end

      def search(attributes, range: "all")
        _search("/api/case/artifact/_search", attributes: attributes, range: range) { |json| json }
      end
    end
  end
end
