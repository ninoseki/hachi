# frozen_string_literal: true

module Hachi
  class API
    attr_reader :api_endpoint
    attr_reader :api_key

    def initialize(api_endpoint: ENV["THEHIVE_API_ENDPOINT"], api_key: ENV["THEHIVE_API_KEY"])
      @api_endpoint = api_endpoint
      raise ArgumentError, "api_endpoint argument is required" unless api_endpoint

      @api_key = api_key
      raise ArgumentError, "api_key argument is required" unless api_key
    end

    def alert
      @alert ||= Clients::Alert.new(api_endpoint: api_endpoint, api_key: api_key)
    end

    def artifact
      @artifact ||= Clients::Artifact.new(api_endpoint: api_endpoint, api_key: api_key)
    end

    def case
      @case ||= Clients::Case.new(api_endpoint: api_endpoint, api_key: api_key)
    end

    def user
      @user ||= Clients::User.new(api_endpoint: api_endpoint, api_key: api_key)
    end
  end
end
