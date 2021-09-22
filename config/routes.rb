Rails.application.routes.draw do
  resources :pictures
  root "welcome#index"

  resources :contact, only: [:index, :new, :create]
  resources :users
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