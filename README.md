# Wazirx Ruby

[![Gem Version](https://img.shields.io/badge/gem%20version-2.0.1-brightgreen?style=flat&logo=rubygems)](https://docs.wazirx.com)

This is an official Ruby wrapper for the Wazirx exchange REST and WebSocket APIs.

##### Notice

We are now at 2.0.1 and there may be things breaking, don't hesitate to raise an issue if you feel so!

## Installation
Generate **API KEY** and **Secret Key** from Wazirx website [here](https://wazirx.com/settings/keys)

Add this line to your application's Gemfile:

```ruby
gem 'wazirx_official'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wazirx_official

## Features

#### Current

* Basic implementation of REST API
  * Easy to use authentication
  * Methods return parsed JSON
  * No need to generate timestamps
  * No need to generate signatures
* Basic implementation of WebSocket API
  * Pass procs or lambdas to event handlers
  * Single and multiple streams supported
  * Runs on EventMachine

#### Planned

* Exception handling with responses
* High level abstraction

## Getting Started

#### REST Client

Require Wazirx:

```ruby
require 'wazirx_official'
```

Create a new instance of the REST Client:

```ruby
# If you only plan on touching public API endpoints, you can forgo any arguments
client = Wazirx::Client::REST.new
# Otherwise provide an api_key and secret_key as keyword arguments
client = Wazirx::Client::REST.new api_key: 'x', secret_key: 'y'
```

Create various requests:

## General Endpoints

#### Ping

```ruby
client.ping
```
Response:
```json-doc
{}
```
#### Server time

```ruby
client.time
```
Response:
```json-doc
{
    "serverTime": 1632375945160
}
```
#### System status

```ruby
client.system_status
```
Response:
```json-doc
{
    "status": "normal",
    "message": "System is running normally."
}
```
#### Exchange info

```ruby
client.exchange_info
```
Response:
```json-doc
{
    "timezone": "UTC",
    "serverTime": 1632376074413,
    "symbols": [
        {
            "symbol": "wrxinr",
            "status": "trading",
            "baseAsset": "wrx",
            "quoteAsset": "inr",
            "baseAssetPrecision": 5,
            "quoteAssetPrecision": 0,
            "orderTypes": [
                "limit",
                "stop_limit"
            ],
            "isSpotTradingAllowed": true,
            "filters": [
                {
                    "filterType": "PRICE_FILTER",
                    "minPrice": "1",
                    "tickSize": "1"
                }
            ]
        }
    ]
}
```
#### Create an order
```ruby
client.create_order! symbol: 'btcinr', side: 'buy', type: 'limit',
  quantity: '100.00000000', price: '0.00055000', recvWindow: 1000
```
Response:
```json-doc
{"id"=>27007862, "symbol"=>"btcinr", "type"=>"limit", "side"=>"buy",
"status"=>"wait", "price"=>"210.0", "origQty"=>"2.0", "executedQty"=>"0.0",
"createdTime"=>1632310960000, "updatedTime"=>1632310960000}
```
##### For other api methods follow [this](https://github.com/WazirX/wazirx-connector-ruby/blob/master/lib/wazirx/client/rest/methods.rb).

Required and optional parameters, as well as enum values, can currently be found on the [Wazirx Documentation](https://docs.wazirx.com). Parameters should always be passed to client methods as keyword arguments in snake_case form.

#### WebSocket Client

Require Wazirx and [EventMachine](https://github.com/eventmachine/eventmachine):

```ruby
require 'wazirx_official'
require 'eventmachine'
```

Create a new instance of the REST Client:

```ruby
# If you only plan on touching public API endpoints, you can forgo any arguments
ws = Wazirx::Client::WebSocket.new
# Otherwise provide an api_key and secret_key as keyword arguments
ws = Wazirx::Client::WebSocket.new api_key: 'x', secret_key: 'y'
```

Create various WebSocket streams, wrapping calls inside `EM.run`:

```ruby
EM.run do

  # Pass the symbol/symbols to subscribe to trades
  ws.trades symbol: ['btcinr','wrxinr'], id: 0, action: 'subscribe'

  # Pass the symbol/symbols to subscribe to depth
  ws.depth symbol: ['btcinr','wrxinr'], id: 0, action: 'subscribe'

  # For all market tickers
  ws.all_market_ticker id: 0, action: 'subscribe'

end
```
##### Note:
* `symbol` can be `Array` for multiple.
* `id` by default is `0`, for unique identification any positive integer can be used.
* `action` only needs to pass in case of `unsubscribe`, default is `subscribe` if no data passed.
#### User Data Stream

User data streams utilize both the REST and WebSocket APIs.

Request a listen key from the REST API, and then create a WebSocket stream using it.

```ruby
EM.run do
  ws.user_stream streams: ['orderUpdate', 'ownTrade', 'outboundAccountPosition'], id: 0, action: 'subscribe'
end
```
##### For other websocket methods follow [this](https://github.com/WazirX/wazirx-connector-ruby/blob/master/lib/wazirx/client/websocket.rb).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at [Issues](https://github.com/WazirX/wazirx-connector-ruby/issues).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
