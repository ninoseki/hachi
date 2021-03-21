# frozen_string_literal: true

module Hachi
  module Models
    class Artifact < Base
      DATA_TYPES = %w(filename file fqdn hash uri_path ip domain mail autonomous-system registry mail_subject regexp user-agent other url).freeze

      attr_reader :data, :data_type, :message, :tlp, :tags

      def initialize(data:, data_type:, message: nil, tlp: nil, tags: nil)
        @data = data
        @data_type = data_type
        @message = message
        @tlp = tlp
        @tags = tags

        raise(ArgumentError, "data is required") unless data
        raise(ArgumentError, "data_type is required") unless data_type
        raise(ArgumentError, "invalid data type") unless DATA_TYPES.include?(data_type)

        validate_tags if tags
        validate_tlp if tlp
      end

      def payload
        {
          data: data,
          dataType: data_type,
          message: message,
          tlp: tlp,
          tags: tags
        }.compact
      end

      def validate_for_creation
        raise(ArgumentError, "message or tags is requried for artifact creation") unless message || tags
      end
    end
  end
end
