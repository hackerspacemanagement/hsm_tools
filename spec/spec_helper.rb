# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require 'factory_girl'
ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')
FactoryGirl.definition_file_paths << File.join(ENGINE_RAILS_ROOT, 'spec', 'factories')
FactoryGirl.find_definitions

require File.expand_path("../../../hsm/config/environment.rb",  __FILE__)

require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end

