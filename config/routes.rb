Rails.application.routes.draw do
  resources :shares
  resources :relationships
  resources :posts
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end