class User < ApplicationRecord
  has_secure_password

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password_digest, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  has_many :debits,  class_name: 'Transfer', foreign_key: :sender_id,   inverse_of: :sender
  has_many :credits, class_name: 'Transfer', foreign_key: :receiver_id, inverse_of: :receiver

  # All transfers from the perspective of the current user
  def history
    credit_lines = credits.map do |transfer|
      { date: transfer.created_at, counterparty: transfer.sender&.email, amount: transfer.amount, note: transfer.note }
    end
    debit_lines = debits.map do |transfer|
      { date: transfer.created_at, counterparty: transfer.receiver&.email, amount: -transfer.amount, note: transfer.note }
    end
    credit_lines.concat(debit_lines).sort_by { |line| line[:date]  }.reverse
  end

  def can_transfer?(amount)
    amount > 0 && amount <= balance
  end

  # Safety can be checked preliminary by #can_transfer? method
  def send_money_to(receiver, amount, note=nil)
    debits.create!(receiver: receiver, amount: amount, note: note)
  end

  # Always safe
  def console_add_money(amount)
    credits.create!(amount: amount, note: "Admin added #{amount} cents")
  end

  # Safety can be checked preliminary by #can_transfer? method
  def console_remove_money(amount)
    debits.create!(amount: amount, note: "Admin removed #{amount} cents")
  end
end
