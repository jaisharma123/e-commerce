Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    omniauth_callbacks:  'users/omniauth_callbacks'
  }

  namespace :admins do
    resources :products
    resources :categories
  end


  resources :products, only: [:show, :index] do
    collection do
      get :filtered_products
    end
  end
  resources :categories, only: [:show, :index]
  get 'home/index'
  get '/contact' => "home#contact"
  get 'home/contact'
  get 'home/admin_page'
  post '/create_contact' => "home#create_contact"

  resources :orders do
    collection do
      post :create_order
      patch :update_item_quantity
      delete :delete_order_item
    end
  end

  resources :carts, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
