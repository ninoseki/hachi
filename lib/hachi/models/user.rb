# frozen_string_literal: true

module Hachi
  module Models
    class User < Base
      attr_reader :login, :name, :roles, :password

      ROLES = %w(read write admin).freeze

      def initialize(login:, name:, roles:, password:)
        @login = login
        @name = name
        @roles = roles
        @password = password

        validate_roles
      end

      def payload
        {
          login: login,
          name: name,
          roles: roles,
          password: password
        }.compact
      end

      private

      def validate_roles
        raise ArgumentError, "roles should be an array" unless roles.is_a?(Array)
        raise ArgumentError, "role should be one of #{ROLES.join('.')}" unless roles.all? { |role| ROLES.include? role }
      end
    end
  end
end
