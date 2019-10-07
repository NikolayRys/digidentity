require 'test_helper'

class TransferTest < ActiveSupport::TestCase
  test 'invalid without participants' do
    assert_not Transfer.new(amount: 10).valid?
  end

  test 'invalid with negative amount' do
    participant = User.create!(email: 'first@email.com', password: 'secret', balance: 10)
    assert_not Transfer.new(sender: participant, amount: -5).valid?
  end
end
