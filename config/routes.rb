Rails.application.routes.draw do

  root to: "users#index"

  get "/newgame", to: "choices#index"
  

end
