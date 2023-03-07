Rails.application.routes.draw do
  resources :posts
  root to: 'users#index'
  resources :users
  # get '/register', to: 'users#new'
  get '/login', to: 'login#login'
  post '/login', to: 'login#actual_login'
  get '/logout', to: 'login#destroy'
  get '/profile', to: 'users#profile'
  get '/profile/edit', to: 'users#profile_edit'
  get '/password/change', to: 'users#password_change'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
