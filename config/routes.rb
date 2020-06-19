# frozen_string_literal: true

Rails.application.routes.draw do
  root 'main#frontpage'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  post '/logout' => 'session#destroy'
  get '/signup' => 'user#new'
  resources :user, only: %i[create show update edit destroy]
  namespace :user do
    resources :membership, only: [:update]
  end
  resources :keychain, only: %i[show new update edit create destroy]
  namespace :keychain do
    resources :membership, only: %i[new create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
