require 'rspec'
require_relative '../browserstack'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end
