require 'net/http'
require 'uri'
require 'openssl'

namespace :orders do
  desc '現在のレートを取得して,条件に一致した場合、ビットコインの売買を行う'
  task :ticker => :environment do
    uri = URI.parse('https://api.bitflyer.jp')
    uri.path = '/v1/ticker'
    uri.query = 'product_code=BTC_JPY'
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    # bitFlyer Lightning Ticker API Call
    response = https.get uri.request_uri
    result = JSON.parse(response.body)

    # Ticker更新
    ticker = Ticker.new(result)
    if ticker.save
      p 'Ticker update success'
    else
      p 'Ticker update faild'
      p 'response: ', result
    end
  end

  task :sendchildorder => :environment do
    uri = URI.parse('https://api.bitflyer.jp')
    uri.path = '/v1/ticker'
    uri.query = 'product_code=BTC_JPY'
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    # bitFlyer Lightning Ticker API Call
    response = https.get uri.request_uri
    result = JSON.parse(response.body)

    ticker = Ticker.last

    # 認証情報
    key = Settings.bitFlyer.key
    secret = Settings.bitFlyer.secret

    # tickerが存在しない場合は処理しない
    if ticker
      # 最終取引確認時間
      last_trade_time = ticker.timestamp
      # 現在時刻
      now_time = Time.now.gmtime
      # 最終取引確認時間 - 現在時刻 = 差分
      minutes_difference = now_time - last_trade_time

      # 現在の最終取引価格
      latest_rate = result['ltp']
      # 前回の最終取引価格
      last_rate = ticker.ltp
      # 前回の最終取引価格との増減率
      rate = (latest_rate - last_rate) / last_rate * 100

      # 資産情報を取得
      timestamp = Time.now.to_i.to_s
      method = 'GET'
      uri.path = '/v1/me/getbalance'

      text = timestamp + method + uri.request_uri
      sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret, text)

      options = Net::HTTP::Get.new(uri.request_uri, initheader = {
          'ACCESS-KEY' => key,
          'ACCESS-TIMESTAMP' => timestamp,
          'ACCESS-SIGN' => sign
      })

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      response = https.request(options)
      balance = JSON.parse(response.body)

      buy_setting = BuySetting.first

      # 買う処理
      if buy_setting
        # 最終確認時間との差分が設定した取引間隔より大きい場合
        if minutes_difference > buy_setting.minutes
          # getbalanceがErrorの場合は処理しない
          if balance.kind_of?(Array)
            jpy = balance.select {|b| b['currency_code'] == 'JPY'}
            jpy_amount = jpy.first['amount']
            if rate < 0 && rate.abs > buy_setting.reduction_percent && jpy_amount > buy_setting.jpy
              timestamp = Time.now.to_i.to_s
              method = "POST"
              uri = URI.parse("https://api.bitflyer.jp")
              uri.path = "/v1/me/sendchildorder"
              body = {
                  "product_code": "BTC_JPY",
                  "child_order_type": "MARKET",
                  "side": "BUY",
                  "size": buy_setting.buy_count
              }

              text = timestamp + method + uri.request_uri + body
              sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret, text)

              options = Net::HTTP::Post.new(uri.request_uri, initheader = {
                  "ACCESS-KEY" => key,
                  "ACCESS-TIMESTAMP" => timestamp,
                  "ACCESS-SIGN" => sign,
                  "Content-Type" => "application/json"
              })
              options.body = body

              https = Net::HTTP.new(uri.host, uri.port)
              https.use_ssl = true
              response = https.request(options)
              puts response.body
            end
          end
        end
      end

      sell_setting = SellSetting.first

      # 売る処理
      if sell_setting
        # 最終確認時間との差分が設定した取引間隔より大きい場合
        if minutes_difference > sell_setting.minutes
          # getbalanceがErrorの場合は処理しない
          if balance.kind_of?(Array)
            bitcoin = balance.select {|b| b['currency_code'] == 'BTC'}
            bitcoin_amount = bitcoin.first['amount']
            # 前回の最終取引価格より増加かつ、ユーザーが設定した増加率以上に増加したかつ、総保有場合Bitcoinがユーザー設定値以上の場合
            if rate > 0 && rate > sell_setting.increase_percent && bitcoin_amount > sell_setting.bitcoin
              timestamp = Time.now.to_i.to_s
              method = "POST"
              uri = URI.parse("https://api.bitflyer.jp")
              uri.path = "/v1/me/sendchildorder"
              body = {
                  "product_code": "BTC_JPY",
                  "child_order_type": "MARKET",
                  "side": "SELL",
                  "size": sell_setting.sell_count
              }

              text = timestamp + method + uri.request_uri + body
              sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret, text)

              options = Net::HTTP::Post.new(uri.request_uri, initheader = {
                  "ACCESS-KEY" => key,
                  "ACCESS-TIMESTAMP" => timestamp,
                  "ACCESS-SIGN" => sign,
                  "Content-Type" => "application/json"
              })
              options.body = body

              https = Net::HTTP.new(uri.host, uri.port)
              https.use_ssl = true
              response = https.request(options)
              puts response.body
            end
          end
        end
      end
    end

    #  bitFlyer Lightning getchildorders API Call
    timestamp = Time.now.to_i.to_s
    method = 'GET'
    uri.path = '/v1/me/getchildorders'

    text = timestamp + method + uri.request_uri
    sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret, text)

    options = Net::HTTP::Get.new(uri.request_uri, initheader = {
        'ACCESS-KEY' => key,
        'ACCESS-TIMESTAMP' => timestamp,
        'ACCESS-SIGN' => sign
    })

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    response = https.request(options)
    childorders = JSON.parse(response.body)

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
