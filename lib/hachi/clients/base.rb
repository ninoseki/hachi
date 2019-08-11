# frozen_string_literal: true

require "json"
require "net/https"

module Hachi
  module Clients
    class Base
      attr_reader :api_endpoint
      attr_reader :api_key

      def initialize(api_endpoint:, api_key:)
        @api_endpoint = URI(api_endpoint)
        @api_key = api_key
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

      def get(path, params = {}, &block)
        url = url_for(path)
        url.query = URI.encode_www_form(params) unless params.empty?

        get = Net::HTTP::Get.new(url)
        get.add_field "Authorization", "Bearer #{api_key}"
        request(get, &block)
      end

      def post(path, params = {}, &block)
        url = url_for(path)

        post = Net::HTTP::Post.new(url)
        post.body = params.is_a?(Hash) ? params.to_json : params.to_s

        post.add_field "Content-Type", "application/json"
        post.add_field "Authorization", "Bearer #{api_key}"

        request(post, &block)
      end

      def delete(path, params = {}, &block)
        url = url_for(path)
        url.query = URI.encode_www_form(params) unless params.empty?

        delete = Net::HTTP::Delete.new(url)
        delete.add_field "Authorization", "Bearer #{api_key}"
        request(delete, &block)
      end

      def validate_range(range)
        return true if range == "all"
        raise ArgumentError, "range should be 'all' or `from-to`" unless range.match?(/(\d+)-(\d+)/)

        from, to = range.split("-").map(&:to_i)
        return true if from < to

        raise ArgumentError, "from should be smaller than to"
      end

      def _search(path, attributes:, range: "all")
        validate_range range

        attributes = normalize_attributes(attributes)
        conditions = attributes.map do |key, value|
          if key == :data && value.is_a?(Array)
            { _or: decompose_data(value) }
          else
            { _string: "#{key}:#{value}" }
          end
        end

        default_conditions = {
          _and: [
            { _not: { status: "Deleted" } },
            { _not: { _in: { _field: "_type", _values: ["dashboard", "data", "user", "analyzer", "caseTemplate", "reportTemplate", "action"] } } },
          ],
        }

        query = {
          _and: [conditions, default_conditions].flatten,
        }

        post("#{path}?range=#{range}", query: query) { |json| json }
      end

      def decompose_data(data)
        data.map do |elem|
          { _field: "data", _value: elem }
        end
      end

      def normalize_attributes(attributes)
        h = {}
        attributes.each do |key, value|
          h[camelize(key).to_sym] = value
        end
        h
      end

      def camelize(string)
        head, *others = string.to_s.split("_")
        [head, others.map(&:capitalize)].flatten.join
      end
    end
  end
end
