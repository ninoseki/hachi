# frozen_string_literal: true

module Hachi
  module Models
    class Artifact
      DATA_TYPES = %w(filename file fqdn hash uri_path ip domain mail autonomous-system registry mail_subject regexp user-agent other url).freeze

      attr_reader :data
      attr_reader :data_type
      attr_reader :message
      attr_reader :tlp
      attr_reader :tags

      def initialize(data:, data_type:, message: nil, tlp: nil, tags: nil)
        @data = data
        @data_type = data_type
        @message = message
        @tlp = tlp
        @tags = tags

        raise(ArgumentError, "data is required") unless data
        raise(ArgumentError, "data_type is required") unless data_type
        raise(ArgumentError, "invalid data type") unless DATA_TYPES.include?(data_type)
        raise(ArgumentError, "tags should be an array") unless tags.nil? || tags.is_a?(Array)
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
    end
  end
end
