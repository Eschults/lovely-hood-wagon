Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "registrations", sessions: "sessions" }
  put "/activity/:id/like_activity", to: "posts#like_activity", as: "like_activity_post"
  patch "/activity/:id/like_activity", to: "posts#like_activity", as: "like_activity_post_2"
  put "/activity/:id/unlike_activity", to: "posts#unlike_activity", as: "unlike_activity_post"
  patch "/activity/:id/unlike_activity", to: "posts#unlike_activity", as: "unlike_activity_post_2"
  put "/activity/:id/comment_activity", to: "posts#update_activity", as: "activity"
  patch "/activity/:id/comment_activity", to: "posts#update_activity", as: "activity_2"
  post 'bookings/:booking_id/reviews', to: "reviews#create", as: "booking_review"
  post 'bookings/:booking_id/conversations', to: "conversations#create_b", as: "booking_conversations"
  post 'users/:user_id/conversations', to: "conversations#create_u", as: "user_conversations"
  put 'bookings/:booking_id/reviews/:id', to: "reviews#update", as: "update_booking_review"
  patch 'bookings/:booking_id/reviews/:id', to: "reviews#update", as: "update_booking_review_2"
  put 'users/:id', to: "users#update", as: "user"
  patch 'users/:id', to: "users#update", as: "user_2"
  post 'offers/:offer_id/bookings', to: "bookings#create", as: 'offer_bookings'
  put 'offers/:offer_id/bookings/:id', to: "bookings#update", as: 'offer_booking'
  patch 'offers/:offer_id/bookings/:id', to: "bookings#update", as: 'offer_booking_2'
  post 'offers/:offer_id/conversations', to: "conversations#create", as: 'offer_conversations'
  post 'offers/:offer_id/stripe_customers', to: "stripe_customers#create", as: "offer_stripe_customers"
  put 'conversations/:id/reply', to: "conversations#reply", as: "reply_conversation"
  patch 'conversations/:id/reply', to: "conversations#reply", as: "reply_conversation_2"
  put 'conversations/:id/reply_server', to: "conversations#reply_server", as: "reply_server_conversation"
  patch 'conversations/:id/reply_server', to: "conversations#reply_server", as: "reply_server_conversation_2"
  post 'bookings/:booking_id/buy', to: "bookings#buy", as: "buy_booking"
  # patch 'bookings/:booking_id/buy', to: "bookings#buy", as: "buy_booking_2"
  post 'bookings/:booking_id/cancel', to: "bookings#cancel", as: "cancel_booking"
  # patch 'bookings/:booking_id/cancel', to: "bookings#cancel", as: "cancel_booking_2"
  scope '(:locale)', locale: /en/ do
    root to: "pages#home"
    get "/legal", to: "pages#legal"
    get "/terms", to: "pages#terms"
    get "/sitemap", to:"pages#sitemap"
    get "/poster", to:"pages#poster"
    get "/early_birds_poster", to:"pages#early_birds_poster"
    get "/users/map", to: "users#map"
    resources :users, only: [:index, :show, :edit]
    resources :offers, except: :destroy do
      member do
        put :wish, to: "offers#wish"
        put :unwish, to: "offers#unwish"
      end
      resources :bookings, only: [:new, :edit, :show]
      resources :conversations, only: :new
      resources :stripe_customers, only: :new
    end
    resources :posts, only: [:index, :create, :update] do
      member do
        put :like, to: "posts#like"
        put :unlike, to: "posts#unlike"
      end
    end
    get 'bookings/:booking_id/reviews/new', to: "reviews#new", as: "new_booking_review"
    get 'bookings/:booking_id/conversations/new', to: "conversations#new_b", as: "new_booking_conversation"
    get 'users/:user_id/conversations/new', to: "conversations#new_u", as: "new_user_conversation"
    get 'bookings/:booking_id/reviews/:id/edit', to: "reviews#edit", as: "edit_booking_review"
    get 'reviews/:id', to: "reviews#show", as: "review"
    get "/mine", to: "offers#mine"
    get "/wishlist", to: "offers#wishlist"
    resources :conversations, only: [:index, :show]
  end
  resources :stripe_payments, only: [:new, :create]
end
