Rails.application.routes.draw do

  root 'store#index', as: 'store'

  resources :items, only: [:show, :index]
  resources :categories, only: [:show, :index]
  resources :carts, only: [:show]
  resources :line_items, only: [:create, :destroy]
  resources :orders, only: [:show, :create]
  
end
