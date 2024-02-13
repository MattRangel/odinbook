Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users, only: [:show, :edit, :update, :index]
  resources :comments, only: [:create]
  resource :relationships, only: [:create, :update, :destroy] do
    collection do
      get 'following'
      get 'followed_by'
      get 'requests'
    end
  end
  resources :likes, only: [:create]
  resources :posts, only: [:create, :new, :show]
  root "homepage#show"
end
