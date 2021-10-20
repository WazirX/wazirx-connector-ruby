require 'date'

module Wazirx
  module Client
    class REST
      # Generate a timestamp in milliseconds and append to query string
      TimestampRequestMiddleware = Struct.new(:app) do
        def call(env)
          key = 'timestamp'
          value = DateTime.now.strftime('%Q')

          if env.method == :get
            env.url.query = REST.add_query_param(
              env.url.query, key, value
            )
          else
            body = REST.sort_body env.body, key, value
            env.body = JSON.generate(body)
          end

          app.call env
        end
      end
    end
  end
end
