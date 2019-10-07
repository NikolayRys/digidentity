ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  (ActiveRecord::Base.connection.tables - %w{schema_migrations}).each do |table_name|
    ActiveRecord::Base.connection.execute "DELETE FROM #{table_name};"
  end
end
