require 'net/http'
require 'uri'
require 'openssl'

namespace :orders do
  desc '現在のレートを取得して,条件に一致した場合、ビットコインの売買を行う'
  task :sendchildorder => :environment do
    # call ticker api
    result = BitFlyer.ticker

    # 買う処理
    buy_setting = BuySetting.first

    if buy_setting&.is_execution
      # 現在時間より設定されたminutes以前のticker情報を取得
      old_ticker = Ticker.get_old(buy_setting.minutes)
      if old_ticker
        # 現在の最終取引価格
        latest_rate = result['ltp']
        p '現在の最終取引価格', latest_rate
        # 前回の最終取引価格
        last_rate = old_ticker.ltp
        p '前回の最終取引価格', last_rate
        # 前回の最終取引価格との増減率
        rate = (latest_rate - last_rate) / last_rate * 100
        p '前回の最終取引価格との増減率', rate

        # call balance api
        balance = BitFlyer.getbalance

        if buy_setting.exec_date
          # 最終取引時間が設定されている場合
          # 現在時刻
          now_time = Time.now.utc
          # 最終取引時刻
          exec_date = buy_setting.exec_date.utc
          # 現在時刻 - 最終取引時刻 = 差分
          minutes_difference = (now_time - exec_date) / 60

          # 最終確認時間との差分が設定した取引間隔より大きい場合
          if minutes_difference >= buy_setting.minutes
            # getbalanceがErrorの場合は処理しない
            if balance.kind_of?(Array)
              jpy = balance.select {|b| b['currency_code'] == 'JPY'}
              jpy_amount = jpy.first['amount']
              p 'jpy', jpy
              p 'jpy_amount', jpy_amount
              p 'rate', rate
              p 'rate.abs', rate.abs
              if rate < 0 && rate.abs > buy_setting.reduction_percent && jpy_amount > buy_setting.jpy
                BitFlyer.sendchildorder('BUY', buy_setting.buy_count)
                buy_setting.exec_date = Time.now.utc
                unless buy_setting.save
                  p 'BuySetting update failed'
                  p 'response: ', executions
                end
              end
            end
          end
        else
          # 初回処理
          # getbalanceがErrorの場合は処理しない
          if balance.kind_of?(Array)
            jpy = balance.select {|b| b['currency_code'] == 'JPY'}
            jpy_amount = jpy.first['amount']
            if rate < 0 && rate.abs > buy_setting.reduction_percent && jpy_amount > buy_setting.jpy
              BitFlyer.sendchildorder('BUY', buy_setting.buy_count)
              buy_setting.exec_date = Time.now.utc
              unless buy_setting.save
                p 'BuySetting update failed'
                p 'response: ', executions
              end
            end
          end
        end
      end
    end

    # 売る処理
    sell_setting = SellSetting.first

    if sell_setting&.is_execution
      # 現在時間より設定されたminutes以前のticker情報を取得
      old_ticker = Ticker.get_old(sell_setting.minutes)

      if old_ticker
        # 現在の最終取引価格
        latest_rate = result['ltp']
        # 前回の最終取引価格
        last_rate = old_ticker.ltp
        # 前回の最終取引価格との増減率
        rate = (latest_rate - last_rate) / last_rate * 100

        # call balance api
        balance = BitFlyer.getbalance

        if sell_setting.exec_date
          # 最終取引時間が設定されている場合
          # 現在時刻
          now_time = Time.now.utc
          exec_date = sell_setting.exec_date.utc
          # 現在時刻 - 最終取引時刻 = 差分
          minutes_difference = (now_time - exec_date) / 60

          if minutes_difference >= sell_setting.minutes
            # getbalanceがErrorの場合は処理しない
            if balance.kind_of?(Array)
              bitcoin = balance.select {|b| b['currency_code'] == 'BTC'}
              bitcoin_amount = bitcoin.first['amount']
              p 'bitcoin', bitcoin
              p 'bitcoin_amount', bitcoin_amount
              p 'rate', rate
              p 'rate.abs', rate.abs
              # 前回の最終取引価格より増加かつ、ユーザーが設定した増加率以上に増加したかつ、総保有場合Bitcoinがユーザー設定値以上の場合
              if rate > 0 && rate.abs > sell_setting.increase_percent && bitcoin_amount > sell_setting.bitcoin
                BitFlyer.sendchildorder('SELL', sell_setting.sell_count)
                sell_setting.exec_date = Time.now.utc
                unless sell_setting.save
                  p 'SellSetting update failed'
                  p 'response: ', executions
                end
              end
            end
          end
        else
          # 初回処理
          if balance.kind_of?(Array)
            bitcoin = balance.select {|b| b['currency_code'] == 'BTC'}
            bitcoin_amount = bitcoin.first['amount']
            # 前回の最終取引価格より増加かつ、ユーザーが設定した増加率以上に増加したかつ、総保有場合Bitcoinがユーザー設定値以上の場合
            if rate > 0 && rate.abs > sell_setting.increase_percent && bitcoin_amount > sell_setting.bitcoin
              BitFlyer.sendchildorder('SELL', sell_setting.sell_count)
              sell_setting.exec_date = Time.now.utc
              unless sell_setting.save
                p 'SellSetting update failed'
                p 'response: ', executions
              end
            end
          end
        end
      end
    end

    # Ticker更新
    ticker = Ticker.new(result)
    unless ticker.save
      p 'Ticker update failed'
      p 'response: ', result
    end

    # call getchildorders api
    childorders = BitFlyer.getchildorders

    # Order更新
    Order.delete_all
    childorders.each do |order|
      order['id'] = nil
      new_order = Order.new(order)
      unless new_order.save
        p 'Order update failed'
        p 'response: ', childorders
      end
    end

    # call getexecutions api
    executions = BitFlyer.getexecutions

    #Execution更新
    Execution.delete_all
    executions.each do |exexution|
      exexution['id'] = nil
      new_execution = Execution.new(exexution)
      unless new_execution.save
        p 'Execution update failed'
        p 'response: ', executions
      end
    end

  end
end
