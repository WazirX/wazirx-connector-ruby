module Wazirx
  module Client
    class REST
      METHODS = [
        # Public API Methods
        # #ping
        { name: :ping, client: :public,
          action: :get, endpoint: :ping },
        # #time
        { name: :time, client: :public,
          action: :get, endpoint: :time },
        # #system_status
        { name: :system_status, client: :public,
          action: :get, endpoint: :system_status },
        # #exchange_info
        { name: :exchange_info, client: :public,
          action: :get, endpoint: :exchange_info },
        # #tickers
        { name: :tickers, client: :public,
          action: :get, endpoint: :tickers },
        # #ticker
        { name: :ticker, client: :public,
          action: :get, endpoint: :ticker },
        # #depth
        { name: :depth, client: :public,
          action: :get, endpoint: :depth },
        # #trades
        { name: :trades, client: :public,
          action: :get, endpoint: :trades },
        # #historical_trades
        { name: :historical_trades, client: :signed,
          action: :get, endpoint: :historical_trades },

        # Account API Methods
        # #create_order!
        { name: :create_order!, client: :signed,
          action: :post, endpoint: :order },
        # #create_test_order
        { name: :create_test_order, client: :signed,
          action: :post, endpoint: :test_order },
        # #query_order
        { name: :query_order, client: :signed,
          action: :get, endpoint: :order },
        # #cancel_order!
        { name: :cancel_order!, client: :signed,
          action: :delete, endpoint: :order },
        # #open_orders
        { name: :open_orders, client: :signed,
          action: :get, endpoint: :open_orders },
        # #cancel_open_orders!
        { name: :cancel_open_orders, client: :signed,
          action: :delete, endpoint: :open_orders },
        # #all_orders
        { name: :all_orders, client: :signed,
          action: :get, endpoint: :all_orders },
        # #account_info
        { name: :account_info, client: :signed,
          action: :get, endpoint: :account },
        # #funds
        { name: :funds_info, client: :signed,
          action: :get, endpoint: :funds },

        # Websocket Auth Token
        # #create_auth_token!
        { name: :create_auth_token!, client: :signed,
          action: :post, endpoint: :ws_auth_token }
      ].freeze
    end
  end
end
