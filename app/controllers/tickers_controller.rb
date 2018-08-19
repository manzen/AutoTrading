class TickersController < ApplicationController
  def show
    @tickers = Ticker.latest
  end

  def change_interval
    p 'tickerの実行間隔を変更する'
    p params['time']
    redirect_to root_url
  end
end
