# frozen_string_literal: true

require "hachi/version"

require "hachi/awrence/methods"

require "hachi/api"

require "hachi/clients/base"

require "hachi/clients/alert"
require "hachi/clients/artifact"
require "hachi/clients/case"
require "hachi/clients/observable"
require "hachi/clients/query"
require "hachi/clients/user"

module Hachi
  module Awrence
    class << self
      attr_writer :acronyms

      def acronyms
        @acronyms ||= {}
      end
    end
  end

  class Error < StandardError; end
end
