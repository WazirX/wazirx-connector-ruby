lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wazirx_official/version'

Gem::Specification.new do |spec|
  spec.name          = 'wazirx_official'
  spec.version       = Wazirx::VERSION
  spec.authors       = ['Som Prabh Sharma']
  spec.email         = ['api@wazirx.com']

  spec.summary       = 'API Wrapper for the Wazirx cryptocurrency exchange.'
  spec.homepage      = 'https://github.com/WazirX/wazirx-connector-ruby'
  spec.license       = 'MIT'

  spec.files         = Dir['bin/*'] +
                       Dir['lib/**/*.rb']

  spec.require_paths = ['lib']

  spec.bindir        = 'bin'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_runtime_dependency 'faraday', '~> 0.12'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.12'
  spec.add_runtime_dependency 'faye-websocket', '~> 0.10'
end
