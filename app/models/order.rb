class Order < ApplicationRecord
  def self.latest
    Order.all.limit(100)
  end
end
