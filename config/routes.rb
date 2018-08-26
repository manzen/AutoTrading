Rails.application.routes.draw do
  root 'tickers#show'
  get 'orders', to: 'orders#show'
  get 'executions', to: 'executions#show'
  resources :buy_settings
  post 'buy_start', to: 'buy_settings#start'
  post 'buy_stop', to: 'buy_settings#stop'
  resources :sell_settings
  post 'sell_start', to: 'sell_settings#start'
  post   'sell_stop', to: 'sell_settings#stop'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
