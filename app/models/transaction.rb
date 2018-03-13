class Transaction < ApplicationRecord
  # include Transactionable
   # class ActiveRecord_Relation
   #  def self.count(category)
   #    puts "category: #{category}"
   #    where(category: category).size
   #  end
  # end

  monetize :amount_cents

  validate :must_be_greater_than_zero
  validates :category, inclusion: %w[deposit refund withdraw]

  belongs_to :user

  after_save :make_immutable
  after_find :make_immutable

  # def one_day(user: user, currency: currency)
  #   where(user_id: user.id,
  #         amount_currency: currency,
  #         created_at: Date.today.beginning_of_day..Date.today.end_of_day
  #         ).select(:amount_currency, :category)
  # end

  # def category_count(category)
  #   where(category: category).size
  # end

  # alias_method :count, :category_count

  def self.amount(category)
    where(category: category.to_s).sum(&:amount)
  end

  private

  def must_be_greater_than_zero
    errors.add(:amount, 'Must be greater than 0') if amount <= Money.from_amount(0, amount_currency)
  end


  def make_immutable
    self.readonly!
  end
end
