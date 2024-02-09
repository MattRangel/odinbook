Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users, only: [:show, :edit, :update, :index]
  resources :comments, only: [:create]
  resources :relationships, only: [:create]
  resources :likes, only: [:create]
  resources :posts, only: [:create, :new, :show]
  root "homepage#show"
end
