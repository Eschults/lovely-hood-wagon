Rails.application.routes.draw do
  root to: "pages#home"
  # devise_for :users
  # resources :users, only: [:show, :edit, :update]
  # resources :offers, except: [:destroy]
end
