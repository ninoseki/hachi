# frozen_string_literal: true

module Hachi
  module Clients
    class User < Base
      def current
        get("/api/user/current") { |json| json }
      end

      def get_by_id(id)
        get("/api/user/#{id}") { |json| json }
      end

      def delete_by_id(id)
        delete("/api/user/#{id}") { |json| json }
      end

      def create(login:, name:, roles:, password:)
        user = Models::User.new(
          login: login,
          name: name,
          roles: roles,
          password: password
        )

        post("/api/user", user.payload) { |json| json }
      end
    end
  end
end
