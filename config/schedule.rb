set :output, 'log/crontab.log'
ENV['RAILS_ENV'] ||= 'development'
set :environment, ENV['RAILS_ENV']

# every 5.minutes do
#   rake "orders:sendchildorder"
# end

every 30.minutes do
  rake "orders:ticker"
end

every :sunday, :at => '12am' do
  rake "ticker_rotate.delete_ticker"
end

