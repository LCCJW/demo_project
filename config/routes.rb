Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root "pages#introduction"

  resources :pages, only: [:index] do
    collection do
      get :newfav
      get :landingpage
      get :introduction
    end
  end

  namespace :api do
    resources :animals, only: [] do
      member do
        post :favorite
      end
    end
  end

  resources :searches, only: [:index, :show] do
    collection do
      get :simple
      get :advance
    end
  end

  resources :favorites


  resources :reservations do
    collection do
      get :testfav
    end
    member do
      delete :cancel
    end
  end

  resource :calander
  resources :messages

  namespace :sender do
    root "pages#index"
    resources :reservations do
      member do
        delete :cancel
        post :confirm
        post :cancel_adopt
        post :adopt
      end
      resources :reservation_pets
    end
    resources :animals do
      delete '/images/:image_id' => 'animals#destroy_image', as: :destroy_image, on: :member
    end
    resource :user
    resource :calander
  end
end
