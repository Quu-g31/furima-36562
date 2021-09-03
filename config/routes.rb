Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

  resources :items, only: [:new, :create]

  get '/items/delivery_fee/:id', to: "items#delivery_fee"
end
