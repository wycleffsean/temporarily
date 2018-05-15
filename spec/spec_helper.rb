require 'bundler/setup'
require 'temporarily'
require 'active_record'

Dir[File.expand_path('support/**/*', __dir__)].each { |file| require file }

RSpec.configure do |config|
  config.filter_run_excluding :ci unless ENV['CI']
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
