# frozen_string_literal: true

require "hachi/version"

require "hachi/api"

require "hachi/models/alert"
require "hachi/models/artifact"
require "hachi/models/case"

require "hachi/clients/base"
require "hachi/clients/alert"
require "hachi/clients/artifact"
require "hachi/clients/case"

module Hachi
  class Error < StandardError; end
end
