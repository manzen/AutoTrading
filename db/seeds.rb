# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Ticker.create(product_code: "BTC_JPY", timestamp: "2018-07-30T03:10:15.913", tick_id: 2267848, best_bid: 907854.0, best_ask: 907998.0, best_bid_size: 0.008, best_ask_size: 0.01, total_bid_depth: 1490.60037128, total_ask_depth: 1930.42856016, ltp: 907902.0, volume: 149428.18179769, volume_by_product: 4584.58341614 )
Setting.create(minutes: 60, increase_percent: 0.1, reduction_percent: 0.2, increase_condition: 10, reduction_condition: 11, buy_count: 10.0, shell_count: 10.1)