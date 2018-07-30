require 'net/http'

namespace :orders do
  desc '現在のレートを確認する'
  task :sample do
    uri = URI.parse("https://api.bitflyer.jp")
    uri.path = '/v1/ticker'
    uri.query = 'product_code=BTC_JPY'
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    response = https.get uri.request_uri
    result = JSON.parse(response.body)
    last_rate = result['ltp']
  end
end
