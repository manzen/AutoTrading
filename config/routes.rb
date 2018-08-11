Rails.application.routes.draw do
  root 'tickers#show'
  resources :buy_settings
  resources :sell_settings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
