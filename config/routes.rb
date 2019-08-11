Rails.application.routes.draw do
  devise_for :users
  resources :events
  resources :users, only: [:show]
  root 'events#index'
end
