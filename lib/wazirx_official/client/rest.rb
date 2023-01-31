require 'faraday'

require_relative 'rest/sign_request_middleware'
require_relative 'rest/timestamp_request_middleware'
require_relative 'rest/clients'
require_relative 'rest/endpoints'
require_relative 'rest/methods'

module Wazirx
  module Client
    class REST
      BASE_URL = 'https://api.wazirx.com'.freeze

      def initialize(api_key: '', secret_key: '',
                     adapter: Faraday.default_adapter)
        @clients = {}
        @clients[:public]   = public_client adapter
        @clients[:signed]   = signed_client api_key, secret_key, adapter
      end

      def call(method, params={})
        return {error: {message: "No method found named #{method}, please check if misspelled!"} }if
        METHODS.select { |mthd| mthd[:name] == method.to_sym}.empty?
        send(method, params)
      end

      METHODS.each do |method|
        define_method(method[:name]) do |options = {}|
          response = @clients[method[:client]].send(method[:action]) do |req|
            req.url ENDPOINTS[method[:endpoint]]
            puts "Params passed #{options}"
            if method[:action] == :get
              req.params.merge! options.map { |k, v| [k.to_s, v] }.to_h
            else
              req.body = JSON.generate(options.map { |k, v| [camelize(k.to_s), v] }.to_h)
            end
          end
          response.body
        end
      end

      def self.add_query_param(query, key, value)
        query = query ? query.split('&') : []
        query << "#{Faraday::Utils.escape key}=#{Faraday::Utils.escape value}"
        query.sort.join('&')
      end

      def self.sort_body(body, key, value)
        body = JSON.parse(body)
        body[key] = value
        body.sort.to_h
      end

      def camelize(str)
        str.split('_')
           .map.with_index { |word, i| i.zero? ? word : word.capitalize }.join
      end
    end
  end
end
