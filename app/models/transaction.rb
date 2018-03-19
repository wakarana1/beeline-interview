class Transaction < ApplicationRecord

  scope :category_count, -> (category) { where(category: category.to_s).size }
  scope :amount, -> (category) { where(category: category.to_s).sum(&:amount) }

  monetize :amount_cents

  validate :must_be_greater_than_zero
  validates :category, inclusion: %w[deposit refund withdraw]

  belongs_to :user

  after_save :make_immutable
  after_find :make_immutable

  private

  def must_be_greater_than_zero
    errors.add(:amount, 'Must be greater than 0') if amount <= Money.from_amount(0, amount_currency)
  end


  def make_immutable
    self.readonly!
  end
end
