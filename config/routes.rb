Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects
  resources :roles do
    member do
      patch :assign
      patch :unassign
    end
  end
  resources :interests

  root 'roles#index'
end
