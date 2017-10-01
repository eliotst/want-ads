Rails.application.routes.draw do
  get 'messages/create'

  get "/logout" => "sessions#destroy", :as => "logout"
  get "/login" => "sessions#new", :as => "login"
  get "/verify_token/:token" => "verification_tokens#verify", :as => "verify_token"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :interests
  resources :people
  resources :projects
  resources :roles do
    member do
      patch :assign
      patch :unassign
    end
  end
  resources :sessions
  resources :verification_tokens

  root 'roles#index'
end
