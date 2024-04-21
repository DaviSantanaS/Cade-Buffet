Rails.application.routes.draw do
  get 'event_prices/index'
  get 'event_prices/new'
  get 'event_prices/create'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: "home#index"

  resources :buffets, only: [:index, :show, :new, :create, :edit, :update] do
    resources :event_types, except: [:show]
  end

  resources :event_types do
    resources :event_prices, only: [:index, :new, :create, :show]
  end

  resources :home, only: [:index]
end
