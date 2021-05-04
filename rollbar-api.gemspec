# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rollbar_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'rollbar-api'
  spec.version       = RollbarApi::VERSION
  spec.authors       = ['Peter Graham']
  spec.email         = ['peter@wealthsimple.com']

  spec.summary       = 'Rubygem for Rollbar REST and RQL APIs'
  spec.description   = "Rubygem for accessing Rollbar's full REST and RQL APIs."
  spec.homepage      = 'https://github.com/wealthsimple/rollbar-api'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.7.3'

  spec.add_dependency 'activesupport', '>= 4'
  spec.add_dependency 'faraday', '< 1.0'
  spec.add_dependency 'recursive-open-struct'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-collection_matchers'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.2'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'webmock', '~> 3.0'
  spec.add_development_dependency 'ws-style'
end
