Rails.application.routes.draw do

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords',
        confirmations: 'users/confirmations',
        omniauth_callbacks:  'users/omniauth_callbacks'
      }
  resources :order_items
  resources :orders
  get 'carts/show'



  namespace :admins do
    resources :products
    resources :categories
  end

  resources :products, only: [:show, :index]
  resources :categories, only: [:show, :index]
  get 'home/index'
  root 'home#index'

  resource :cart, only: [:show] do
  put 'add/product_id', to: 'carts#add', as: :add_to
  put 'remove/:product_id', to: 'carts#remove', as: :remove_from
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
