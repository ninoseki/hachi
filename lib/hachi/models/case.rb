# frozen_string_literal: true

module Hachi
  module Models
    class Case
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

      def validate_severity
        return true if severity >= 1 && severity <= 3

        raise ArgumentError, "severity should be 1 - 3 (1: low; 2: medium; 3: high)."
      end

      def validate_start_date
        DateTime.parse(start_date)
        true
      rescue ArgumentError => _
        raise ArgumentError, "date should be Date format."
      end

      def validate_tlp
        return true if tlp >= 0 && severity <= 3

        raise ArgumentError, "tlp should be 0 - 3 (0: white; 1: green; 2: amber; 3: red)."
      end

      def validate_flag
        return true if [true, false].include?(flag)

        raise ArgumentError, "flag should be true or false."
      end
    end
  end
end
