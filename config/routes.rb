Rails.application.routes.draw do
  post "orders/create", to: "orders#create"
  resources :webhooks, only: [:create]
  get "success", to: "orders#success"
  get "cancel", to: "orders#cancel"

  post "pictures/add_to_cart/:id", to: "pictures#add_to_cart", as: "add_to_cart"
  delete "pictures/remove_from_cart/:id", to: "pictures#remove_from_cart", as: "remove_from_cart"
  resources :pictures
  root "welcome#index"

  resources :contact, only: [:index, :new, :create]
  resources :users

  
  get "/portfolio/:portfolio" => "portfolio#index"
    resources :portfolio
  

  get "/bio/:bio" => "bio#index"
    resources :bio
  

  get "/contact/:contact" => "contact#index"
  get '/signup', to: 'users#new'
  get '/login', to: 'users#login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end  