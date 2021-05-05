Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "home#index"
  resources :users do 
  	resources :posts do
      member do 
        put "apply", to: "posts#apply"
      end
    end
  end

  get 'cities/:state', to: 'application#cities'
  	
  get "/sign_up" => "users#new", as: "sign_up"
  get "/sign_in" => "sessions#new", as: "sign_in"
  post "/login" => "sessions#create", as: "login"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/search" => "home#search"

  get "/*path" => "home#index"
end