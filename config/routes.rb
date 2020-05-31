Rails.application.routes.draw do
  root 'main#frontpage'
  resources :user, only: %i[create new show update destroy]
  get '/about' => 'main#about'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  post '/logout' => 'session#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
