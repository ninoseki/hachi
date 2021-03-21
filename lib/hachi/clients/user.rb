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
        get("/api/user/current") { |json| json }
      end

      #
      # Get a user
      #
      # @param [String] id User ID
      #
      # @return [Hash]
      #
      def get_by_id(id)
        get("/api/user/#{id}") { |json| json }
      end

      #
      # Delete a user
      #
      # @param [String] id User ID
      #
      # @return [String]
      #
      def delete_by_id(id)
        delete("/api/user/#{id}") { |json| json }
      end

      #
      # Create a user
      #
      # @param [String] login
      # @param [String] name
      # @param [Array<String>] roles
      # @param [String] password
      #
      # @return [Hash]
      #
      def create(login:, name:, roles:, password:)
        user = Models::User.new(
          login: login,
          name: name,
          roles: roles,
          password: password
        )

        post("/api/user", json: user.payload) { |json| json }
      end
    end
  end
end
