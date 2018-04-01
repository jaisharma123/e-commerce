Rails.application.routes.draw do
  get 'order_items/create'

  get 'order_items/update'

  get 'order_items/destroy'

  root 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    omniauth_callbacks:  'users/omniauth_callbacks'
  }

  get 'carts/show'
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]


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

  # resource :cart, only: [:show] do
  #   put 'add/product_id', to: 'carts#add', as: :add_to
  #   put 'remove/:product_id', to: 'carts#remove', as: :remove_from
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
