Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations'}
  resources :tasks
  resources :comments
  resources :messages
  resources :users, only: [:show]
  resources :teams, only: [:new, :create, :edit, :update]
  root 'tasks#index'

  namespace :users  do
    resources :team_roles, only: [:edit, :update]
    resources :settings, only: [:edit, :update]
    resources :join_teams, only: :new
    post '/:id/join_team' => '/users/join_teams#create', as: 'join_team'
  end
  namespace :static_screens do
    get '/expect_invitation' => '/static_screens#expect_invitation', as: 'expect_invitation'
  end

  mount ActionCable.server => '/cable'
end
