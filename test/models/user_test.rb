require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'invalid email' do
    assert_not User.new(email: 'invaild', password: 'secret').valid?
  end

  test 'valid email' do
    assert User.new(email: 'valid@email.com', password: 'secret').valid?
  end

  test 'secure password' do
    user = User.new(email: 'valid@email.com', password: 'secret')
    user.save
    assert_not_nil user.password_digest
  end

  test 'disallows negative_balance' do
    user = User.new(email: 'valid@email.com', password: 'secret', balance: -5)
    assert_not user.valid?
  end
end
