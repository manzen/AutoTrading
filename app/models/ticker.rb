class Ticker < ApplicationRecord
  def self.latest
    Ticker.all.order(id: 'DESC').limit(100)
  end

  def self.get_old(minutes_num)
    Ticker.where('created_at <= ?', Time.now.utc - minutes_num.minutes).order(id: 'DESC').first
  end

  def self.delete_ticker
    Ticker.where(created_at: 1.week.ago.all_day).delete_all
  end
end
