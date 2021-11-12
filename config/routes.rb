Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/users/:user_id/posts", to: "posts#index", as: "user_posts"
  post "/users/:user_id/posts", to: "posts#create", as: "user_create_post"
  get "/users/:user_id/posts/new", to: "posts#new", as: "user_new_post"
  get "/users/:user_id/posts/:id", to: "posts#show", as: "user_post"
  delete "/users/:user_id/posts/:id", to: "posts#destroy", as: "user_destroy_post"
  delete "/users/:user_id/posts/:id/:comment_id", to: "comments#destroy", as: "user_destroy_post_comment"
  post "/users/:user_id/posts/:id", to: "comments#create", as: "user_create_post_comment"
  get "/users/:user_id/posts/:id/new", to: "comments#new", as: "user_new_post_comment"
  post "/users/:user_id/posts/:id/like", to: "likes#create", as: "user_create_post_like"
  get "/users", to: "users#index", as: "users"
  get "/users/:id", to: "users#show", as: "user"
  post "auth/login", to: "authentication#authenticate"
  root to: "users#index"
end