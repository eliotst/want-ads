Rails.application.routes.draw do
  get 'person_roles/destroy'

  get 'messages/create'

  get "/logout" => "sessions#destroy", :as => "logout"
  get "/login" => "sessions#new", :as => "login"
  get "/verify_token/:token" => "verification_tokens#verify", :as => "verify_token"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :interests do
    member do
      post :assign
    end
  end
  resources :home
  resources :messages
  resources :people
  resources :person_roles
  resources :projects
  resources :roles
  resources :sessions
  resources :tasks do
    member do
      post :complete
      post :uncomplete
      post :volunteer
      post :unassign
    end
  end
  resources :verification_tokens

  root 'home#index'
end
