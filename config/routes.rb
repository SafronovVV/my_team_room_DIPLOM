Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  resources :comments
  resources :messages
  root 'tasks#index'

  mount ActionCable.server => '/cable'
end
