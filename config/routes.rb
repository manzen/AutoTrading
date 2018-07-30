Rails.application.routes.draw do
  get 'settings/show'
  get 'tickers/show'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
