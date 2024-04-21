Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: "home#index"

  resources :buffets, only: [:index, :show, :new, :create, :edit, :update]
  resources :home, only: [:index]

end
