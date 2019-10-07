require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'invalid email' do
    assert_not User.new(email: 'invaild', password: 'secret').valid?
  end

  test 'valid email' do
    assert User.new(email: 'valid@email.com', password: 'secret').valid?
  end

  test 'unique email' do
    User.create!(email: 'valid@email.com', password: 'secret')
    assert_raise(ActiveRecord::RecordInvalid){ User.create!(email: 'valid@email.com', password: 'secret') }
  end

  test 'secure password' do
    user = User.new(email: 'valid@email.com', password: 'secret')
    user.save
    assert_not_nil user.password_digest
  end

  test 'can check affordability' do
    user = User.create!(email: 'first@email.com', password: 'secret', balance: 100)
    assert user.can_transfer?(50)
    assert_not user.can_transfer?(200)
  end

  test 'disallows negative_balance' do
    user = User.new(email: 'valid@email.com', password: 'secret', balance: -5)
    assert_not user.valid?
  end

  test 'can get money by console API' do
    user = User.create!(email: 'first@email.com', password: 'secret')
    user.console_add_money(100)
    assert_equal user.balance, 100
  end

  test 'can have the money removed by console API' do
    user = User.create!(email: 'first@email.com', password: 'secret', balance: 100)
    user.console_remove_money(50)
    assert_equal user.balance, 50
  end

  test 'can perform only positive transfer' do
    first_user = User.create!(email: 'first@email.com', password: 'secret', balance: 100)
    second_user = User.create!(email: 'second@email.com', password: 'secret')
    assert_raises ActiveRecord::RecordInvalid do
       first_user.send_money_to(second_user, -10)
    end
  end

  test 'cannot perform transfer larger than balance' do
    first_user = User.create!(email: 'first@email.com', password: 'secret', balance: 100)
    second_user = User.create!(email: 'second@email.com', password: 'secret')
    assert_raises ActiveRecord::RecordInvalid do
       first_user.send_money_to(second_user, 200)
    end
  end

  test 'history consist from credits and debits' do
    first_user = User.create!(email: 'first@email.com', password: 'secret', balance: 100)
    second_user = User.create!(email: 'second@email.com', password: 'secret')
    first_user.send_money_to(second_user, 50, 'first payment')
    second_user.send_money_to(first_user, 20, 'second payment')

    assert_equal first_user.history.map{|line| line[:amount]}, [20, -50]
    assert_equal second_user.history.map{|line| line[:amount]}, [-20, 50]
  end

end
