class OrdersController < ApplicationController
  def show
    @orders = Order.latest
  end
end
