require 'test_helper'

class TransferTest < ActiveSupport::TestCase
  test 'invalid without participants' do
    assert_not Transfer.new(amount: 10).valid?
  end

  test 'invalid with negative amount' do
    participant = User.create!(email: 'first@email.com', password: 'secret', balance: 100)
    assert_not Transfer.new(sender: participant, amount: -5).valid?
  end

  test 'affects participants balance' do
    first_user = User.create!(email: 'first@email.com', password: 'secret', balance: 100)
    second_user = User.create!(email: 'second@email.com', password: 'secret')

    Transfer.create!(sender: first_user, receiver: second_user, amount: 30)

    assert_equal first_user.balance, 70
    assert_equal second_user.balance, 30
  end

  test 'is readonly' do
    participant = User.create!(email: 'first@email.com', password: 'secret', balance: 100)
    transfer = Transfer.create!(sender: participant, amount: 30)
    assert_raise(ActiveRecord::RecordInvalid){ transfer.update!(amount: 50) }
  end

end
