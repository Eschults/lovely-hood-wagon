Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "registrations" }
  root to: "pages#home"
  resources :users, only: [:show, :edit, :update]
  resources :offers, except: [:destroy] do
    resources :bookings, only: [:new, :create, :edit, :update, :show] do
      member do
        put :confirm
      end
    end
    resources :conversations, only: [:new, :create]
  end

  get 'bookings/:booking_id/reviews/new', to: "reviews#new", as: "new_booking_review"

  post 'bookings/:booking_id/reviews', to: "reviews#create", as: "booking_review"

  get 'bookings/:booking_id/reviews/:id/edit', to: "reviews#edit", as: "edit_booking_review"

  put 'bookings/:booking_id/reviews/:id', to: "reviews#update", as: "update_booking_review"

  get 'reviews/:id', to: "reviews#show", as: "review"

  get "/mine", to: "offers#mine"
  get "/wishlist", to: "offers#wishlist"

  resources :conversations, only: [:index, :show] do
    member do
      put :reply
      put :reply_server
    end
  end

end
