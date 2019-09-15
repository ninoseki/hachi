# frozen_string_literal: true

require "hachi/version"

require "hachi/api"

require "hachi/models/base"
require "hachi/models/alert"
require "hachi/models/artifact"
require "hachi/models/case"
require "hachi/models/user"

require "hachi/clients/base"
require "hachi/clients/alert"
require "hachi/clients/artifact"
require "hachi/clients/case"
require "hachi/clients/user"

module Hachi
  class Error < StandardError; end
end
