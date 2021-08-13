Rails.application.routes.draw do
  root "welcome#index"

  resources :contact, only: [:index, :new, :create]

  
  get "/portfolio/:portfolio" => "portfolio#index"
    resources :portfolio
  

  get "/bio/:bio" => "bio#index"
    resources :bio
  

  get "/contact/:contact" => "contact#index"
end  