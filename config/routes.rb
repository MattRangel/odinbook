Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "user/omniauth_callbacks" }
  resources :users, only: [:show, :edit, :update]
  resources :comments, only: [:create]
  resources :relationships, only: [:create]
  resources :likes, only: [:create]
  resources :posts, only: [:create, :new, :show]
  root "homepage#show"
end
