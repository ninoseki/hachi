# frozen_string_literal: true

module Hachi
  module Clients
    class User < Base
      #
      # Get current user
      #
      # @return [Hash]
      #
      def current
        get("/user/current") { |json| json }
      end

      #
      # Get a user
      #
      # @param [String] id User ID
      #
      # @return [Hash]
      #
      def get_by_id(id)
        get("/user/#{id}") { |json| json }
      end

      #
      # Delete a user
      #
      # @param [String] id User ID
      #
      # @return [String]
      #
      def delete_by_id(id)
        delete("/user/#{id}") { |json| json }
      end

      #
      # Create a user
      #
      # @param [Hash] payload
      #
      # @return [Hash]
      #
      def create(**payload)
        post("/user", json: payload) { |json| json }
      end
    end
  end
end
