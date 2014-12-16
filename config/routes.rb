Rails.application.routes.draw do

  get 'conversations/index'

  get 'conversations/new'

  get 'conversations/create'

  get 'conversations/show'

  get 'conversations/reply'

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
