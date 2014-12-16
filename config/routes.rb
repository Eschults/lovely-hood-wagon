Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: "pages#home"
  resources :users, only: [:show, :edit, :update]
  resources :offers, except: [:destroy] do
    resources :bookings, only: [:new, :create, :edit, :update, :show]
  end

  resources :conversations, only: [:index, :new, :create, :show] do
    member do
      put :reply
    end
  end
end
