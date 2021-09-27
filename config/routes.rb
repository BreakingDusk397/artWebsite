Rails.application.routes.draw do

  root "pages#home"
  
  resources :webhooks, only: [:create]

  post "orders/create", to: "orders#create"
  get "success", to: "orders#success"
  get "cancel", to: "orders#cancel"
  resources :orders

  post "pictures/add_to_cart/:id", to: "pictures#add_to_cart", as: "add_to_cart"
  delete "pictures/remove_from_cart/:id", to: "pictures#remove_from_cart", as: "remove_from_cart"
  resources :pictures
  
  get "home", to: "pages#home"
  get "bio", to: "pages#bio"
  get "portfolio", to: "pages#portfolio"
  get "contact", to: "pages#contact"
  post "contact", to: "pages#create"
  resources :pages
  
  get '/dashboard', to: 'users#dashboard'
  get '/signup', to: 'users#new'
  get '/login', to: 'users#login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users

end  