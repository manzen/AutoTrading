require 'net/http'

namespace :orders do
  desc '現在のレートを確認する'
  task :sample => :environment do
    uri = URI.parse("https://api.bitflyer.jp")
    uri.path = '/v1/ticker'
    uri.query = 'product_code=BTC_JPY'
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    # ticker api call
    response = https.get uri.request_uri
    # response body to json
    result = JSON.parse(response.body)
    last_rate = result['ltp']

    # update ticker
    ticker = Ticker.new(result)
    if ticker.save
      p 'Ticker update success'
    else
      p 'Ticker update faild'
      p 'response: ', result
    end

  end
end
