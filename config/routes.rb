Rails.application.routes.draw do
  get 'offers/new'

  get 'offers/create'

  get 'offers/edit'

  get 'offers/update'

  get 'offers/show'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: "pages#home"
  resources :users, only: [:show, :edit, :update]
  resources :offers, except: [:destroy]
end
