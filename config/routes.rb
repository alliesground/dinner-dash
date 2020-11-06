Rails.application.routes.draw do
  devise_for :users
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

  namespace :cart do
    resources :cart_items, only: [:create, :destroy, :update, :index] do
      collection do
        delete 'destroy_all'
      end
    end

    get '/checkout', to: 'cart_items#checkout'
  end

  resources :orders, only: [:index, :create]
end
