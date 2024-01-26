Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :comments, only: [:create]
  root "homepage#show"
end
