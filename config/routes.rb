# frozen_string_literal: true

Rails.application.routes.draw do
  resources :orders
  resources :suppliers
  resources :addresses
  resources :users

  resources :clients do
    get :search, on: :collection
  end

  resources :items do
    get :search, on: :collection
  end

  resources :client_orders, controller: :orders, type: 'ClientOrder'

  get 'items/:id/movements' => 'order_items#index', as: :item_movements

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'orders#index'
end
