Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get 'ui(/:action)', controller: 'ui'
  root to: "home#index"

  resources :users, only: :show

  resources :projects, only: :show
  resources :project_forms, only: [:new, :create]

  get 'choose_role' => 'roles#new'
  post 'roles' => 'roles#create'

  resources :invitations, only: [:new, :create]
end
