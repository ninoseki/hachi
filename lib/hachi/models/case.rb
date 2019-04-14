# frozen_string_literal: true

module Hachi
  module Models
    class Case < Base
      attr_reader :title
      attr_reader :description
      attr_reader :severity
      attr_reader :start_date
      attr_reader :owner
      attr_reader :flag
      attr_reader :tlp
      attr_reader :tags

      def initialize(title:, description:, severity: nil, start_date: nil, owner: nil, flag: nil, tlp: nil, tags: nil)
        @title = title
        @description = description
        @severity = severity
        @start_date = start_date
        @owner = owner
        @flag = flag
        @tlp = tlp
        @tags = tags

        validate_flag if flag
        validate_severity if severity
        validate_start_date if start_date
        validate_tags if tags
        validate_tlp if tlp
      end

      def payload
        {
          title: title,
          description: description,
          severity: severity,
          startDate: start_date,
          owner: owner,
          flag: flag,
          tlp: tlp,
          tags: tags
        }.compact
      end

      private

      def validate_start_date
        DateTime.parse(start_date)
        true
      rescue ArgumentError => _
        raise ArgumentError, "date should be Date format"
      end

      def validate_flag
        return true if [true, false].include?(flag)

        raise ArgumentError, "flag should be true or false"
      end
    end
  end
end
