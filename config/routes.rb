Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  resources :posts
  root to: 'users#index'
  resources :users
  get '/login', to: 'login#login'
  post '/login', to: 'login#actual_login'
  get '/logout', to: 'login#destroy'
  get '/profile/:id', to: 'users#profile'
  get '/password/change/:id', to: 'users#password_change'
  post '/actual/change/:id', to: 'users#actual_password_change'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
