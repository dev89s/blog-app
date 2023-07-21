Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/users/:user_id/posts", to: "posts#index", as: 'posts'
  get "/users/:user_id/posts/new", to: "posts#new", as: 'new_post'
  post "/users/:user_id/posts/create", to: "posts#create"
  get "/users/:user_id/posts/:id", to: "posts#show"
  get "/users", to: "users#index"
  get "/", to: "users#index"
  get "/users/:id", to: "users#show"

  # Defines the root path route ("/")
  # root "articles#index"
end
