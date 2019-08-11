# frozen_string_literal: true

module Hachi
  module Models
    class Base
      private

      def validate_severity
        return true if severity >= 1 && severity <= 3

        raise ArgumentError, "severity should be 1 - 3 (1: low; 2: medium; 3: high)"
      end

      def validate_tlp
        return true if tlp >= 0 && tlp <= 3

        raise ArgumentError, "tlp should be 0 - 3 (0: white; 1: green; 2: amber; 3: red)"
      end

      def validate_status
        return true if %w(New Updated Ignored Imported).include?(status)

        raise ArgumentError, "status should be New, Updated, Ignored or Imported"
      end

      def validate_tags
        raise ArgumentError, "tags should be an array" unless tags.is_a?(Array)
      end
    end
  end
end
