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

  resources :carts, only: :show
  
  resources :cart_items, only: :create do
    collection do
      delete 'destroy_all'
    end
  end

  resources :carts do
    resources :cart_items, only: [:create], controller: 'carts/cart_items'
  end
end
