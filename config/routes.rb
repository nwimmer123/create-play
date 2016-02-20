Rails.application.routes.draw do

  root to: "users#index"

  get "/users", to: "users#index", as: "users"
  get "/users/new", to: "users#new", as: "new_user"
  post "/users", to:"users#create"
  get "/users/:id", to: "users#show", as: "user"

  get "/login", to:"sessions#new"

  get "/newgame", to: "choices#index"

  get "/newgame/backstory", to: "games#new"
  post "/newgame/backstory", to: "games#create"


end
