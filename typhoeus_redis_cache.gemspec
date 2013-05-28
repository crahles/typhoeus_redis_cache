# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'typhoeus_redis_cache/version'

Gem::Specification.new do |spec|
  spec.name          = 'typhoeus_redis_cache'
  spec.version       = TyphoeusRedisCache::VERSION
  spec.authors       = ['crahles']
  spec.email         = ['christoph@rahles.de']
  spec.description   = %q{Cache responses from typhoeus in redis}
  spec.summary       = %q{Cache responses from typhoeus in redis}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'typhoeus'
  spec.add_dependency 'redis'
  spec.add_dependency 'oj'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'fakeredis'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rspec_junit_formatter'
end
