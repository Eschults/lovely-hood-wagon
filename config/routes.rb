Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # devise_for :users
  # resources :users, only: [:show, :edit, :update]
  # resources :offers, except: [:destroy]
end
