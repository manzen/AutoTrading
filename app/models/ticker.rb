class Ticker < ApplicationRecord
  def self.latest
    Ticker.all.order(id: 'DESC').limit(100)
  end

  def self.delete_ticker
    Ticker.where(created_at: 1.month.ago.all_day).delete_all
  end
end
