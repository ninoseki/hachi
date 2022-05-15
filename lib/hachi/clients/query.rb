# frozen_string_literal: true

module Hachi
  module Clients
    class Query < Base
      #
      # Query
      #
      # @param [Hash] payload
      #
      # @return [Hash]
      #
      def query(**payload)
        post("/query", json: payload) { |json| json }
      end
    end
  end
end
