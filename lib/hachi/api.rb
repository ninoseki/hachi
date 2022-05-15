# frozen_string_literal: true

require "forwardable"

module Hachi
  class API
    extend Forwardable

    # @return [String] TheHive API endpoint
    attr_reader :api_endpoint

    # @return [String] TheHive API key
    attr_reader :api_key

    # @return [String, nil] TheHive API version
    attr_reader :api_version

    #
    # @param [String, nil] api_endpoint TheHive API endpoint
    # @param [String, nil] api_key TheHive API key
    # @param [String, nil] api_version TheHive API version
    #
    # @raise [ArgumentError] When given or an empty endpoint or key
    #
    def initialize(api_endpoint: ENV.fetch("THEHIVE_API_ENDPOINT", nil), api_key: ENV.fetch("THEHIVE_API_KEY", nil), api_version: ENV.fetch("THEHIVE_API_VERSION", nil))
      @api_endpoint = api_endpoint
      raise ArgumentError, "api_endpoint argument is required" unless api_endpoint

      @api_key = api_key
      raise ArgumentError, "api_key argument is required" unless api_key

      @api_version = api_version

      @base = Clients::Base.new(api_endpoint: api_endpoint, api_key: api_key, api_version: api_version)
    end

    def_delegators :@base, :get, :post, :delete, :push

    #
    # Alert API endpoint client
    #
    # @return [Clients::Alert]
    #
    def alert
      @alert ||= Clients::Alert.new(api_endpoint: api_endpoint, api_key: api_key, api_version: api_version)
    end

    #
    # Artifact API endpoint client
    #
    # @return [Clients::Artifact]
    #
    def artifact
      @artifact ||= Clients::Artifact.new(api_endpoint: api_endpoint, api_key: api_key, api_version: api_version)
    end

    #
    # Case API endpoint client
    #
    # @return [Clients::Case]
    #
    def case
      @case ||= Clients::Case.new(api_endpoint: api_endpoint, api_key: api_key, api_version: api_version)
    end

    #
    # User API endpoint client
    #
    # @return [Clients::User]
    #
    def user
      @user ||= Clients::User.new(api_endpoint: api_endpoint, api_key: api_key, api_version: api_version)
    end

    #
    # Observable API endpoint client
    #
    # @return [Clients::Observable]
    #
    def observable
      @observable ||= Clients::Observable.new(api_endpoint: api_endpoint, api_key: api_key, api_version: api_version)
    end

    #
    # Query API endpoint client
    #
    # @return [Clients::Query]
    #
    def query
      @query ||= Clients::Query.new(api_endpoint: api_endpoint, api_key: api_key, api_version: api_version)
    end
  end
end
