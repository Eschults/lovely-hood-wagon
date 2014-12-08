Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: "pages#home"
  # devise_for :users
  # resources :users, only: [:show, :edit, :update]
  # resources :offers, except: [:destroy]
end
