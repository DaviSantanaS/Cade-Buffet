Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :orders do
    member do
      get 'edit_price', to: 'orders#edit_price'
      patch 'update_price', to: 'orders#update_price'
    end
  end

  root to: "home#index"

  resources :buffets, only: [:index, :show, :new, :create, :edit, :update] do
    resources :event_types, only: [:index, :new, :create, :show]
    resources :orders, only: [:new, :create, :index, :update]
  end

  resources :orders, only: [:index, :show, :update]

  resources :event_types do
    resources :event_prices, only: [:index, :new, :create, :show]
  end

  resources :home, only: [:index]

  get 'event_types/:id/days', to: 'event_types#days', as: 'event_type_days'

  get '/search', to: 'buffets#search', as: 'search'
end
