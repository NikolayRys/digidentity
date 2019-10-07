require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid email' do
    assert_not User.new(email: 'invaild').valid?
  end

  test 'invalid email' do
    assert User.new(email: 'valid@email.com').valid?
  end
end
