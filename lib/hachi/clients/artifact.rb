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
          tags: tags
        )

        post("/api/case/#{case_id}/artifact", artifact.payload) { |json| json }
      end

      def get_by_id(id)
        get("/api/case/artifact/#{id}") { |json| json }
      end

      def delete_by_id(id)
        delete("/api/case/artifact/#{id}") { |json| json }
      end

      def search(data:, data_type:, range: "all")
        validate_range range

        artifact = Models::Artifact.new(data: data, data_type: data_type)
        payload = {
          query: {
            _and:
              [
                { _field: "data", _value: artifact.data },
                { _field: "dataType", _value: artifact.data_type },
                { _and:
                  [
                    { _not: { status: "Deleted" } },
                    { _not:
                      { _in: { _field: "_type", _values: ["dashboard", "data", "user", "analyzer", "caseTemplate", "reportTemplate", "action"] } } }
                  ] }
              ]
          }
        }

        post("/api/case/artifact/_search?range=#{range}", payload) { |json| json }
      end
    end
  end
end
