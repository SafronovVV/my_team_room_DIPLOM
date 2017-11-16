Rails.application.routes.draw do
  resources :tasks
  resources :comments
  root 'tasks#index'
end
