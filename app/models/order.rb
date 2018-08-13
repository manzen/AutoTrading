class Order < ApplicationRecord
  def self.latest
    Order.all.order(id: 'DESC').limit(100)
  end
end
