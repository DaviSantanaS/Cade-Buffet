Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: "home#index"

  resources :buffets, only: [:index, :show, :new, :create, :edit, :update] do
    resources :event_types, only: [:index, :new, :create, :show]
    resources :orders, only: [:new, :create]
  end

  resources :orders, only: [:index, :show]

  resources :event_types do
    resources :event_prices, only: [:index, :new, :create, :show]
  end

  resources :home, only: [:index]


  get '/search', to: 'buffets#search', as: 'search'
end
