class User < ApplicationRecord
  has_secure_password

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  has_many :debits,  class_name: 'Transfer', foreign_key: :sender_id,   inverse_of: :sender
  has_many :credits, class_name: 'Transfer', foreign_key: :receiver_id, inverse_of: :receiver

  def transfers
    credits.or(debits).order(:created_at)
  end

  def can_transfer?(amount)
    amount >= 0 && amount <= balance
  end

  # Safety can be checked preliminary by #can_transfer? method
  def send_money_to(receiver, amount, note=nil)
    debits.create!(receiver: receiver, amount: amount, note: note)
  end

  # Safety can be checked preliminary by #can_transfer? method
  def console_add_money(amount)
    credits.create!(amount: amount, note: "Admin added #{amount}")
  end

  # Always safe
  def console_remove_money(amount)
    credits.create!(amount: amount, note: "Admin removed #{amount}")
  end

end
