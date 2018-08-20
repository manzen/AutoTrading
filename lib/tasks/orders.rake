require 'net/http'
require 'uri'
require 'openssl'

namespace :orders do
  desc '現在のレートを取得して,条件に一致した場合、ビットコインの売買を行う'
  task :sendchildorder => :environment do
    # call ticker api
    result = BitFlyer.ticker

    # # 最新のtickerを取得
    # ticker = Ticker.last
    #
    # # tickerが存在しない場合は処理しない
    # if ticker
    #   # 最終取引確認時間
    #   last_trade_time = ticker.timestamp
    #   # 現在時刻
    #   now_time = Time.now.gmtime
    #   # 最終取引確認時間 - 現在時刻 = 差分
    #   minutes_difference = now_time - last_trade_time
    #
    #   # 現在の最終取引価格
    #   latest_rate = result['ltp']
    #   # 前回の最終取引価格
    #   last_rate = ticker.ltp
    #   # 前回の最終取引価格との増減率
    #   rate = (latest_rate - last_rate) / last_rate * 100
    #
    #   # call balance api
    #   balance = BitFlyer.getbalance
    #
    #   # 買う処理
    #   buy_setting = BuySetting.first
    #
    #   if buy_setting&.is_execution
    #     # 最終確認時間との差分が設定した取引間隔より大きい場合
    #     if minutes_difference > buy_setting.minutes
    #       # getbalanceがErrorの場合は処理しない
    #       if balance.kind_of?(Array)
    #         jpy = balance.select {|b| b['currency_code'] == 'JPY'}
    #         jpy_amount = jpy.first['amount']
    #         if rate < 0 && rate.abs > buy_setting.reduction_percent && jpy_amount > buy_setting.jpy
    #           p '買う'
    #           # BitFlyer.sendchildorder('BUY', buy_setting.buy_count)
    #         end
    #       end
    #     end
    #   end
    #
    #   # 売る処理
    #   sell_setting = SellSetting.first
    #
    #   if sell_setting&.is_execution
    #     # 最終確認時間との差分が設定した取引間隔より大きい場合
    #     if minutes_difference > sell_setting.minutes
    #       # getbalanceがErrorの場合は処理しない
    #       if balance.kind_of?(Array)
    #         bitcoin = balance.select {|b| b['currency_code'] == 'BTC'}
    #         bitcoin_amount = bitcoin.first['amount']
    #         # 前回の最終取引価格より増加かつ、ユーザーが設定した増加率以上に増加したかつ、総保有場合Bitcoinがユーザー設定値以上の場合
    #         if rate > 0 && rate > sell_setting.increase_percent && bitcoin_amount > sell_setting.bitcoin
    #           p '売る'
    #           # BitFlyer.sendchildorder('SELL', sell_setting.sell_count)
    #         end
    #       end
    #     end
    #   end
    # end

    # Ticker更新
    ticker = Ticker.new(result)
    if ticker.save
      p 'Ticker update success'
    else
      p 'Ticker update faild'
      p 'response: ', result
    end

    # call getchildorders api
    childorders = BitFlyer.getchildorders

    # Order更新
    Order.delete_all
    childorders.each do |order|
      order['id'] = nil
      order = Order.new(order)
      if order.save
        p 'Order update success'
      else
        p 'Order update faild'
        p 'response: ', childorders
      end
    end
  end
end
