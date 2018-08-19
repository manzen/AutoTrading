Rails.application.routes.draw do
  root 'tickers#show'
  post 'change_interval', to: 'tickers#change_interval'
  get 'orders', to: 'orders#show'
  post 'order_start', to: 'orders#start'
  post 'order_stop', to: 'orders#stop'
  resources :buy_settings
  resources :sell_settings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
