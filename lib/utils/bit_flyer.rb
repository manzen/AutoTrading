module BitFlyer

  @key = Settings.bitFlyer.key
  @secret = Settings.bitFlyer.secret

  def self.ticker
    uri = URI.parse('https://api.bitflyer.jp')
    uri.path = '/v1/ticker'
    uri.query = 'product_code=BTC_JPY'
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    # bitFlyer Lightning Ticker API Call
    response = https.get uri.request_uri
    return JSON.parse(response.body)
  end

  def self.getbalance
    uri = URI.parse('https://api.bitflyer.jp')
    uri.path = '/v1/ticker'
    uri.query = 'product_code=BTC_JPY'
    timestamp = Time.now.to_i.to_s
    method = 'GET'
    uri.path = '/v1/me/getbalance'

    text = timestamp + method + uri.request_uri
    sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @secret, text)

    options = Net::HTTP::Get.new(uri.request_uri, initheader = {
        'ACCESS-KEY' => @key,
        'ACCESS-TIMESTAMP' => timestamp,
        'ACCESS-SIGN' => sign
    })

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    response = https.request(options)
    return JSON.parse(response.body)
  end

  def self.getchildorders
    uri = URI.parse('https://api.bitflyer.jp')
    uri.path = '/v1/ticker'
    uri.query = 'product_code=BTC_JPY'
    timestamp = Time.now.to_i.to_s
    method = 'GET'
    uri.path = '/v1/me/getchildorders'

    text = timestamp + method + uri.request_uri
    sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @secret, text)

    options = Net::HTTP::Get.new(uri.request_uri, initheader = {
        'ACCESS-KEY' => @key,
        'ACCESS-TIMESTAMP' => timestamp,
        'ACCESS-SIGN' => sign
    })

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    response = https.request(options)
    return JSON.parse(response.body)
  end

  def self.sendchildorder(side, size)
    timestamp = Time.now.to_i.to_s
    method = 'POST'
    uri = URI.parse('https://api.bitflyer.jp')
    uri.path = '/v1/me/sendchildorder'
    body = "{
        'product_code': 'BTC_JPY',
        'child_order_type': 'MARKET',
        'side': side,
        'size': size
    }"

    text = timestamp + method + uri.request_uri + body
    sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @secret, text)

    options = Net::HTTP::Post.new(uri.request_uri, initheader = {
        'ACCESS-KEY' => @key,
        'ACCESS-TIMESTAMP' => timestamp,
        'ACCESS-SIGN' => sign,
        'Content-Type' => 'application/json'
    })
    options.body = body

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    response = https.request(options)
    puts response.body
  end

  def self.getexecutions
    timestamp = Time.now.to_i.to_s
    method = 'GET'
    uri = URI.parse('https://api.bitflyer.jp')
    uri.path = '/v1/me/getexecutions'


    text = timestamp + method + uri.request_uri
    sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @secret, text)

    options = Net::HTTP::Get.new(uri.request_uri, initheader = {
        'ACCESS-KEY' => @key,
        'ACCESS-TIMESTAMP' => timestamp,
        'ACCESS-SIGN' => sign,
    });

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    response = https.request(options)
    return JSON.parse(response.body)
  end
end