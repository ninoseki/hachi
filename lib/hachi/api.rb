# frozen_string_literal: true

module Hachi
  class API
    # @return [String] TheHive API endpoint
    attr_reader :api_endpoint

    # @return [String] TheHive API key
    attr_reader :api_key

    #
    # @param [String, nil] api_endpoint TheHive API endpoint
    # @param [String, nil] api_key TheHive API key
    #
    # @raise [ArgumentError] When given or an empty endpoint or key
    #
    def initialize(api_endpoint: ENV["THEHIVE_API_ENDPOINT"], api_key: ENV["THEHIVE_API_KEY"])
      @api_endpoint = api_endpoint
      raise ArgumentError, "api_endpoint argument is required" unless api_endpoint

      @api_key = api_key
      raise ArgumentError, "api_key argument is required" unless api_key
    end

    #
    # Alert API endpoint client
    #
    # @return [Clients::Alert]
    #
    def alert
      @alert ||= Clients::Alert.new(api_endpoint: api_endpoint, api_key: api_key)
    end

    #
    # Artifact API endpoint client
    #
    # @return [Clients::Artifact]
    #
    def artifact
      @artifact ||= Clients::Artifact.new(api_endpoint: api_endpoint, api_key: api_key)
    end

    #
    # Case API endpoint client
    #
    # @return [Clients::Case]
    #
    def case
      @case ||= Clients::Case.new(api_endpoint: api_endpoint, api_key: api_key)
    end

    #
    # User API endpoint client
    #
    # @return [Clients::User]
    #
    def user
      @user ||= Clients::User.new(api_endpoint: api_endpoint, api_key: api_key)
    end
  end
end
