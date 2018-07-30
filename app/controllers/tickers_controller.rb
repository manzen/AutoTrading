class TickersController < ApplicationController
  def show
    @tickers = Ticker.all
  end
end
