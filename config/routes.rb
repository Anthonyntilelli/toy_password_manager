Rails.application.routes.draw do
  root 'main#frontpage'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  post '/logout' => 'session#destroy'
  get '/signup' => 'user#new'
  resources :user, only: %i[create show update edit destroy]
  resources :keychain, only: %i[create show update edit destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
