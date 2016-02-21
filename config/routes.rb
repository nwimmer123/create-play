Rails.application.routes.draw do

  root to: 'users#index'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  
  get '/home', to: 'users#index'
  get '/profile', to: "users#profile", as: "my_profile"
  get '/signup', to: 'users#new', as: 'new_user'
  post '/users', to: 'users#create'
  get '/users/:id', to: 'users#show', as: 'user_profile'

  get '/games', to: 'games#index', as: 'all_games'
  get '/games/:id', to: 'games#show', as: 'one_game'

end
