Rails.application.routes.draw do
  scope "(:locale)", locale: /en|pt-BR/ do
    devise_for :users, controllers: {
      registrations: 'users/registrations'
    }


    resources :orders do
      member do
        get 'edit_price', to: 'orders#edit_price'
        patch 'update_price', to: 'orders#update_price'
        patch 'confirm_by_client', to: 'orders#confirm_by_client'
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
      member do
        patch 'add_photo'
      end
    end

    resources :home, only: [:index]


    get 'event_types/:id/days', to: 'event_types#days', as: 'event_type_days'

    get '/search', to: 'buffets#search', as: 'search'


    namespace :api do
      namespace :v1 do
        resources :buffets, only: [:show, :index] do
          resources :event_types, only: [:index] do
            member do
              post 'check_availability'
            end
          end
        end
      end
    end

  end
end
