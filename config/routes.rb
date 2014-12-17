Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: "pages#home"
  resources :users, only: [:show, :edit, :update]
  resources :offers, except: [:destroy] do
    resources :bookings, only: [:new, :create, :edit, :update, :show]
    resources :conversations, only: [:new, :create]
  end

  resources :conversations, only: [:index, :show] do
    member do
      put :reply
      put :reply_server
    end
  end

end
