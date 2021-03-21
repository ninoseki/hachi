# frozen_string_literal: true

require "date"
require "securerandom"

module Hachi
  module Models
    class Alert < Base
      attr_reader :title, :description, :severity, :date, :tags, :tlp, :status, :type, :source, :source_ref, :artifacts, :follow

      def initialize(title:, description:, type:, source:, severity: nil, date: nil, tags: nil, tlp: nil, status: nil, source_ref: nil, artifacts: nil, follow: nil)
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
        @artifacts = artifacts.nil? ? nil : artifacts.map { |a| Artifact.new(**a) }
        @follow = follow

        validate_date if date
        validate_severity if severity
        validate_status if status
        validate_tlp if tlp
        validate_artifacts if artifacts
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
          artifacts: artifacts&.map(&:payload),
          follow: follow
        }.compact
      end

      private

      def validate_date
        DateTime.parse(date)
        true
      rescue ArgumentError => _e
        raise ArgumentError, "date should be Date format"
      end

      def validate_artifacts
        artifacts.each(&:validate_for_creation)
      end
    end
  end
end
