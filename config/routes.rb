Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/users/:user_id/posts", to: "posts#index", as: 'posts'
  get "/users/:user_id/posts/new", to: "posts#new", as: 'new_post'
  post "/users/:user_id/posts/create", to: "posts#create"
  get "/users/:user_id/posts/:id", to: "posts#show"
  get "/users/:user_id/posts/:id/new_comment", to: "posts#new_comment", as: 'new_comment'
  post "/users/:user_id/posts/:id/create_comment", to: "posts#create_comment", as: 'create_comment'
  post "/users/:user_id/posts/:id/add_like", to: "posts#add_like", as: 'add_like'
  post "/users/:user_id/posts/:id/delete_post", to: "posts#delete_post", as: 'delete_poste'
  post "/users/:user_id/posts/:id/:comment_id/delete_comment", to: "posts#delete_comment", as: 'delete_comment'
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index, :show] do
      resources :posts, only: [:index, :show] do
        resources :comments, only: [:index, :new, :create] do
          collection do
            get 'comments', action: 'show'
            post 'comments', action: 'new'
          end
        end
      end
    end
  end

  # Defines the root path route ("/")
  root "users#index"
end
