SPEC_ROOT = File.dirname(__FILE__)
$LOAD_PATH.unshift SPEC_ROOT
$LOAD_PATH.unshift(File.join(SPEC_ROOT, "..", "lib"))

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}
require 'pry'
require 'fakeredis/rspec'
require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require 'rspec_junit_formatter'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

require 'typhoeus_redis_cache'
