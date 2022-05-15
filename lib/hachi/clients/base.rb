# frozen_string_literal: true

require "json"
require "net/https"
require "uri"

module Hachi
  module Clients
    class Base
      # @return [String]
      attr_reader :api_endpoint

      # @return [String]
      attr_reader :api_key

      # @return [String, nil]
      attr_reader :api_version

      include Hachi::Awrence::Methods

      def initialize(api_endpoint:, api_key:, api_version:)
        @api_endpoint = URI(api_endpoint)
        @api_key = api_key
        @api_version = api_version
      end

      def get(path, params: {}, &block)
        url = url_for(path)
        url.query = URI.encode_www_form(params) unless params.empty?

        get = Net::HTTP::Get.new(url)
        get.add_field "Authorization", "Bearer #{api_key}"
        request(get, &block)
      end

      def post(path, params: {}, json: {}, &block)
        url = url_for(path)
        url.query = URI.encode_www_form(params) unless params.empty?

        json = to_camelback_keys(json.compact) if json.is_a?(Hash)

        post = Net::HTTP::Post.new(url)
        post.body = json.is_a?(Hash) ? json.to_json : json.to_s

        post.add_field "Content-Type", "application/json"
        post.add_field "Authorization", "Bearer #{api_key}"

        request(post, &block)
      end

      def delete(path, params: {}, json: {}, &block)
        url = url_for(path)
        url.query = URI.encode_www_form(params) unless params.empty?

        json = to_camelback_keys(json.compact) if json.is_a?(Hash)

        delete = Net::HTTP::Delete.new(url)
        delete.body = json.is_a?(Hash) ? json.to_json : json.to_s

        delete.add_field "Authorization", "Bearer #{api_key}"
        request(delete, &block)
      end

      def patch(path, params: {}, json: {}, &block)
        url = url_for(path)
        url.query = URI.encode_www_form(params) unless params.empty?

        json = to_camelback_keys(json.compact) if json.is_a?(Hash)

        patch = Net::HTTP::Patch.new(url)
        patch.body = json.is_a?(Hash) ? json.to_json : json.to_s

        patch.add_field "Content-Type", "application/json"
        patch.add_field "Authorization", "Bearer #{api_key}"

        request(patch, &block)
      end

      private

      def base_url
        if api_version.nil? || api_version.to_s.empty?
          "#{api_endpoint.scheme}://#{api_endpoint.hostname}:#{api_endpoint.port}/api"
        else
          "#{api_endpoint.scheme}://#{api_endpoint.hostname}:#{api_endpoint.port}/api/#{api_version}"
        end
      end

      def url_for(path)
        URI(base_url + path)
      end

      def https_options
        return nil if api_endpoint.scheme != "https"

        if proxy = ENV.fetch("HTTPS_PROXY") { ENV.fetch("https_proxy", nil) }
          uri = URI(proxy)
          {
            proxy_address: uri.hostname,
            proxy_port: uri.port,
            proxy_from_env: false,
            use_ssl: true
          }
        else
          { use_ssl: true }
        end
      end

      def http_options
        if proxy = ENV.fetch("HTTP_PROXY") { ENV.fetch("http_proxy", nil) }
          uri = URI(proxy)
          {
            proxy_address: uri.hostname,
            proxy_port: uri.port,
            proxy_from_env: false
          }
        else
          {}
        end
      end

      def parse_body(body)
        JSON.parse body.to_s
      rescue JSON::ParserError => _e
        body.to_s
      end

      def request(req)
        Net::HTTP.start(api_endpoint.hostname, api_endpoint.port, https_options || http_options) do |http|
          response = http.request(req)
          json = parse_body(response.body)

          code = response.code
          unless code.start_with? "20"
            raise Error, "Unsupported response code returned: #{code} (#{json})"
          end

          yield json
        end
      end

      def build_query_string(params)
        URI.encode_www_form(params.compact)
      end
    end
  end
end
