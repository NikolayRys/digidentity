class Transfer < ApplicationRecord
  belongs_to :sender, class_name: 'User', inverse_of: :debits, optional: true
  belongs_to :receiver, class_name: 'User', inverse_of: :credits, optional: true

  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validate :parties_presence
  after_create :adjust_balance


  def parties_presence
    errors.add(:base, 'At least one participant needs to be present') if sender.blank? && receiver.blank?
  end

  def adjust_balance
    # When ActiveRecord::RecordInvalid is raised the transfer won't be saved
    ActiveRecord::Base.transaction do
      sender&.update!(balance: sender.balance - amount)
      receiver&.update!(balance: receiver.balance + amount)
    end
  end
end
