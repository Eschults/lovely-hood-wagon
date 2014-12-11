Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: "pages#home"
  resources :users, only: [:show, :edit, :update]
  resources :offers, except: [:destroy]

  # get "inbox", to: "inbox#index"
  # get "inbox/conversation_with/:user_id", to: "inbox#conversation_with"
  # post "inbox/conversation_with/:user_id/message", to: "inbox#"
end
