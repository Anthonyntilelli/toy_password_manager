# frozen_string_literal: true

Rails.application.routes.draw do
  root 'main#frontpage'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/auth/:provider/callback' => 'sessions#create_omniauth' # OAuth
  post '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'

  resources :users, only: %i[create show update edit destroy] do
    resources :memberships, only: [:update]
  end

  resources :keychains, only: %i[show new update edit create destroy] do
    resources :accounts, only: %i[new create show update edit destroy]
    resources :memberships, only: %i[new create]
  end

  get '/keychains/:id/active_members' => 'keychains#active_members', as: :keychains_active_members
  get '/keychains/:id/inactive_members' => 'keychains#inactive_members', as: :keychains_inactive_members

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
