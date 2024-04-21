Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: "home#index"

  resources :buffets, only: [:index, :show, :new, :create, :edit, :update] do
    resources :event_types, except: [:show]
  end

  resources :home, only: [:index]
end
