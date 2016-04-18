Rails.application.routes.draw do
  root 'home#index'

  get '/signup', to: "users#new"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :links, only: [:index]
end