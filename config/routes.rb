Rails.application.routes.draw do
  # rspec mail
  default_url_options host: 'scm.myattheingiaung@gmail.com'

  # letter opener web
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  get 'home/index'
  devise_for :users, controllers: { invitations: 'users/invitations' }
  resources :posts
  root to: 'posts#index'
  resources :users
  get '/login', to: 'login#login'
  post '/login', to: 'login#actual_login'
  get '/logout', to: 'login#destroy'
  get '/profile/:id', to: 'users#profile'
  post '/posts/import', to: 'posts#import'
  post '/users/import', to: 'users#import'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
