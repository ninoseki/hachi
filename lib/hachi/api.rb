# frozen_string_literal: true

module Hachi
  class API
    attr_reader :alert
    attr_reader :artifact
    attr_reader :case

    def initialize(api_endpoint: ENV["THEHIVE_API_ENDPOINT"], api_key: ENV["THEHIVE_API_KEY"])
      raise(ArgumentError, "api_endpoint argument is required") unless api_endpoint
      raise(ArgumentError, "api_key argument is required") unless api_key

      @alert = Clients::Alert.new(api_endpoint: api_endpoint, api_key: api_key)
      @artifact = Clients::Artifact.new(api_endpoint: api_endpoint, api_key: api_key)
      @case = Clients::Case.new(api_endpoint: api_endpoint, api_key: api_key)
    end
  end
end
