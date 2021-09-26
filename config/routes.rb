Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  root "welcome#index"
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  

  resources :contact, only: [:index, :new, :create]

  
  get "/portfolio/:portfolio" => "portfolio#index"
    resources :portfolio
  

  get "/bio/:bio" => "bio#index"
    resources :bio

  get "/devise/:sessions" => "sessions#index"
    resources :devise
  

  get "/contact/:contact" => "contact#index"
end  