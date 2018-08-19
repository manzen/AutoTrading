class OrdersController < ApplicationController
  def show
    @orders = Order.latest
  end

  def start
    p '取引開始'
    redirect_to orders_url
  end

  def stop
    p '取引停止'
    redirect_to orders_url
  end
end
