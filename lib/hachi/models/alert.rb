# frozen_string_literal: true

require "date"
require "securerandom"

module Hachi
  module Models
    class Alert
      attr_reader :title
      attr_reader :description
      attr_reader :severity
      attr_reader :date
      attr_reader :tags
      attr_reader :tlp
      attr_reader :status
      attr_reader :type
      attr_reader :source
      attr_reader :source_ref
      attr_reader :artifacts
      attr_reader :follow

      def initialize(title:, description:, severity: nil, date: nil, tags: nil, tlp: nil, status: nil, type:, source:, source_ref: nil, artifacts: nil, follow: nil)
        @title = title
        @description = description
        @severity = severity
        @date = date
        @tags = tags
        @tlp = tlp
        @status = status
        @type = type
        @source = source
        @source_ref = source_ref || SecureRandom.hex(10)
        @artifacts = artifacts
        @follow = follow

        validate_date if date
        validate_severity if severity
        validate_status if status
        validate_tlp if tlp
      end

      def payload
        {
          title: title,
          description: description,
          severity: severity,
          date: date,
          tags: tags,
          tlp: tlp,
          status: status,
          type: type,
          source: source,
          sourceRef: source_ref,
          artifacts: artifacts,
          follow: follow
        }.compact
      end

      private

      def validate_severity
        return true if severity >= 1 && severity <= 3

        raise ArgumentError, "severity should be 1 - 3 (1: low; 2: medium; 3: high)."
      end

      def validate_date
        DateTime.parse(date)
        true
      rescue ArgumentError => _
        raise ArgumentError, "date should be Date format."
      end

      def validate_tlp
        return true if tlp >= 0 && severity <= 3

        raise ArgumentError, "tlp should be 0 - 3 (0: white; 1: green; 2: amber; 3: red)."
      end

      def validate_status
        return true if %w(New Updated Ignored Imported).include?(status)

        raise ArgumentError, "status should be New, Updated, Ignored or Imported"
      end
    end
  end
end
