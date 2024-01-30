Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :comments, only: [:create]
  resources :relationships, only: [:create]
  resources :likes, only: [:create]
  resources :posts, only: [:create, :new, :show]
  root "homepage#show"
end
