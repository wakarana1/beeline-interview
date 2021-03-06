class FinancialSummary < ApplicationRecord

  scope :one_day, -> (user: user, currency: currency) {
    one_day_range = Time.now.beginning_of_day..Time.now.end_of_day
    find_transaction(user.id, currency).where(created_at: one_day_range)
  }
  scope :seven_days, -> (user: user, currency: currency) {
    seven_days_range = (Time.now.beginning_of_day - 7.days)..Time.now.end_of_day
    find_transaction(user.id, currency).where(created_at: seven_days_range)
  }
  scope :lifetime, -> (user: user, currency: currency) {
    find_transaction(user.id, currency)
  }

  def self.find_transaction(user_id, currency)
    Transaction.where(user_id: user_id,
                      amount_currency: currency.to_s.upcase
                      )
  end

end
