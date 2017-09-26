Rails.application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"

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

  root 'roles#index'
end
