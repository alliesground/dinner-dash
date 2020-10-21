Rails.application.routes.draw do
  devise_for :admins

  root to: 'home#index'

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :items do
      collection do
        delete '/images/:id', to: 'items#delete_attached_image', as: :delete_attached_image
      end
    end

    resources :categories
    resources :orders
  end
  resources :search

  resources :items, only: :index

  resources :carts, only: [] do
    resources :cart_items, only: [:create], controller: 'carts/cart_items' do
      collection do
        delete 'destroy_all'
      end
    end
  end

  get '/checkout', to: 'carts/cart_items#index', as: :checkout
end
