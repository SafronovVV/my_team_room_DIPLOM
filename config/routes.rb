Rails.application.routes.draw do
  resources :tasks
  resources :comments
  resources :messages
  root 'tasks#index'

  mount ActionCable.server => '/cable'
end
