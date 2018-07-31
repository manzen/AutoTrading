class Ticker < ApplicationRecord
  def self.latest
    Ticker.all.order(id: 'DESC').limit(100)
  end
end
