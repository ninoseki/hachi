# frozen_string_literal: true

require "json"
require "net/https"
require "uri"

module Hachi
  module Clients
    class Base
      attr_reader :api_endpoint, :api_key

      def initialize(api_endpoint:, api_key:)
        @api_endpoint = URI(api_endpoint)
        @api_key = api_key
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

        post = Net::HTTP::Post.new(url)
        post.body = json.is_a?(Hash) ? json.to_json : json.to_s

        post.add_field "Content-Type", "application/json"
        post.add_field "Authorization", "Bearer #{api_key}"

        request(post, &block)
      end

      def delete(path, params: {}, json: {}, &block)
        url = url_for(path)
        url.query = URI.encode_www_form(params) unless params.empty?

        delete = Net::HTTP::Delete.new(url)
        delete.body = json.is_a?(Hash) ? json.to_json : json.to_s

        delete.add_field "Authorization", "Bearer #{api_key}"
        request(delete, &block)
      end

      def patch(path, params: {}, json: {}, &block)
        url = url_for(path)
        url.query = URI.encode_www_form(params) unless params.empty?

        patch = Net::HTTP::Patch.new(url)
        patch.body = json.is_a?(Hash) ? json.to_json : json.to_s

        patch.add_field "Content-Type", "application/json"
        patch.add_field "Authorization", "Bearer #{api_key}"

        request(patch, &block)
      end

      private

      def base_url
        "#{api_endpoint.scheme}://#{api_endpoint.hostname}:#{api_endpoint.port}"
      end

      def url_for(path)
        URI(base_url + path)
      end

      def https_options
        return nil if api_endpoint.scheme != "https"

        if proxy = ENV["HTTPS_PROXY"] || ENV["https_proxy"]
          uri = URI(proxy)
          {
            proxy_address: uri.hostname,
            proxy_port: uri.port,
            proxy_from_env: false,
            use_ssl: true,
          }
        else
          { use_ssl: true }
        end
      end

      def http_options
        if proxy = ENV["HTTP_PROXY"] || ENV["http_proxy"]
          uri = URI(proxy)
          {
            proxy_address: uri.hostname,
            proxy_port: uri.port,
            proxy_from_env: false,
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

      def validate_range(range)
        return true if range == "all"
        raise ArgumentError, "range should be 'all' or `from-to`" unless range.match?(/(\d+)-(\d+)/)

        from, to = range.split("-").map(&:to_i)
        return true if from < to

        raise ArgumentError, "from should be smaller than to"
      end

      def _search(path, query:, range: "all", sort: nil)
        validate_range range

        query_string = build_query_string(range: range, sort: sort)

        post("#{path}?#{query_string}", json: { query: query }) { |json| json }
      end

      def build_query_string(params)
        URI.encode_www_form(params.reject { |_k, v| v.nil? })
      end
    end
  end
end
