namespace :ticker_rotate do
  desc 'tickerを定期的に削除'
  task :delete_ticker => :environment do
    Ticker.delete_ticker
  end
end
