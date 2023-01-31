require 'faraday_middleware'

module Wazirx
  module Client
    class REST
      def public_client(adapter)
        Faraday.new(url: "#{BASE_URL}/sapi") do |conn|
          conn.request :multipart
          conn.request :url_encoded
          conn.response :json, content_type: /\bjson$/
          conn.adapter adapter
        end
      end

      def signed_client(api_key, secret_key, adapter)
        Faraday.new(url: "#{BASE_URL}/sapi") do |conn|
          conn.request :multipart
          conn.request :url_encoded
          conn.response :json, content_type: /\bjson$/
          conn.headers['X-API-KEY'] = api_key
          conn.use TimestampRequestMiddleware
          conn.use SignRequestMiddleware, secret_key
          conn.adapter :net_http
        end
      end
    end
  end
end
