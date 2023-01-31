module Wazirx
  module Client
    class REST
      # Sign the query string using HMAC(sha-256) and appends to query string
      SignRequestMiddleware = Struct.new(:app, :secret_key) do
        def call(env)
          key = 'signature'
          hash = OpenSSL::HMAC.hexdigest(
            OpenSSL::Digest.new('sha256'), secret_key, env.method == :get ? env.url.query : URI.encode_www_form(JSON.parse(env.body))
          )
          if env.method == :get
            env.url.query = REST.add_query_param(env.url.query, 'signature', hash)
          else
            body = REST.sort_body env.body, key, hash
            env.body = URI.encode_www_form(body)
          end

          app.call env
        end
      end
    end
  end
end
