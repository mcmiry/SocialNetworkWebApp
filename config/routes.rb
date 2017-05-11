Rails.application.routes.draw do
  resources :likes
  root 'posts#index'
  
  get "logout" => "session#destroy", :as => "logout"
  get "login" => "session#new", :as => "login"
  post "login" => "session#create"
  get "signup" => "users#new", :as => "signup"

  get 'like/:id', to: 'likes#like_post', as: 'like_post'

  get 'share/:id', to: 'posts#share', as: 'share'

  get 'friend/:id', to: 'relationships#friend', as: 'friend'
  get 'unfriend/:id', to: 'relationships#unfriend', as: 'unfriend'
  get 'accept/:id', to: 'relationships#accept_friend', as: 'accept_friend'
  get 'deny/:id', to: 'relationships#deny_friend', as: 'deny_friend'

  get 'delete/:id', to: 'users#delete', as: 'delete_user'
  get 'delete/:id', to: 'posts#delete', as: 'delete_post'
  get 'delete/:id', to: 'messages#delete', as: 'delete_message'

  resources :messages
  resources :relationships
  resources :posts
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
