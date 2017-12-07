Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations'}
  resources :tasks
  resources :comments
  resources :messages
  resources :users, only: [:show]
  put '/teams/:id/update' => 'teams#update', as: 'update_team'
  resources :teams
  root 'tasks#index'

  namespace :users  do
    resources :team_roles, only: [:edit, :update]
    resources :settings, only: [:edit, :update]
  end

  mount ActionCable.server => '/cable'
end
