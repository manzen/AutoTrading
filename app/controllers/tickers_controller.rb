class TickersController < ApplicationController
  def show
    @tickers = Ticker.latest
  end
end
