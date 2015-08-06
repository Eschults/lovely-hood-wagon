Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "registrations", sessions: "sessions" }
  scope '(:locale)', locale: /en/ do
    root to: "pages#home"
    get "/legal", to: "pages#legal"
    get "/terms", to: "pages#terms"
    get "/sitemap", to:"pages#sitemap"
    get "/poster", to:"pages#poster"
    get "/early_birds_poster", to:"pages#early_birds_poster"
    get "/users/map", to: "users#map"
    resources :users, only: [:index, :show, :edit, :update]
    resources :offers, except: [:destroy] do
      member do
        put :wish, to: "offers#wish"
        put :unwish, to: "offers#unwish"
      end
      resources :bookings, only: [:new, :create, :edit, :update, :show] do
        member do
          put :buy, to: "bookings#buy"
          put :cancel, to: "bookings#cancel"
        end
      end
      resources :conversations, only: [:new, :create]
      resources :stripe_customers, only: [:new, :create]
    end
    resources :posts, only: [:index, :create, :update] do
      member do
        put :like, to: "posts#like"
        put :unlike, to: "posts#unlike"
      end
    end
    put "/activity/:id/like_activity", to: "posts#like_activity", as: "like_activity_post"
    put "/activity/:id/unlike_activity", to: "posts#unlike_activity", as: "unlike_activity_post"
    put "/activity/:id/comment_activity", to: "posts#update_activity", as: "activity"

    get 'bookings/:booking_id/reviews/new', to: "reviews#new", as: "new_booking_review"
    get 'bookings/:booking_id/conversations/new', to: "conversations#new_b", as: "new_booking_conversation"
    post 'bookings/:booking_id/conversations', to: "conversations#create_b", as: "booking_conversations"

    get 'users/:user_id/conversations/new', to: "conversations#new_u", as: "new_user_conversation"
    post 'users/:user_id/conversations', to: "conversations#create_u", as: "user_conversations"

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

  resources :stripe_payments, only: [:new, :create]
end
