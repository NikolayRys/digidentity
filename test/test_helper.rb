ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'database_cleaner'

class ActiveSupport::TestCase
  DatabaseCleaner.strategy = :deletion
  def self.teardown
    DatabaseCleaner.clean
  end
end
