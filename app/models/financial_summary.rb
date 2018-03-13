class FinancialSummary

  def self.one_day(user: user, currency: currency)
    one_day_range = Date.today.beginning_of_day..Date.today.end_of_day
    find_transaction(user.id, currency.to_s.upcase).where(created_at: one_day_range)
  end

  def self.seven_days(user: user, currency: currency)
    seven_days_range = (Date.today.beginning_of_day - 7.days)..Date.today.end_of_day
    find_transaction(user.id, currency.to_s.upcase).where(created_at: seven_days_range)
  end

  def self.lifetime(user: user, currency: currency)
    find_transaction(user.id, currency.to_s.upcase)
  end

  def self.find_transaction(user_id, currency)
    Transaction.where(user_id: user_id,
                      amount_currency: currency,
                      ).select(:amount_currency, :category)
  end

end
