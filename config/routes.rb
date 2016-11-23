Rails.application.routes.draw do

  get 'users/show', as: 'user'
  get 'users/index', as: 'users'

  root 'posts#index'
  resources :posts
  devise_for :users
  resources :friendships, only: [:create, :destroy]
end
