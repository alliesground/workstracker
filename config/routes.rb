Rails.application.routes.draw do
  devise_for :users

  get 'ui(/:action)', controller: 'ui'
  root to: "home#index"
  resources :users, only: :show
  resources :projects, only: [:new, :show, :create]
  resources :project_forms, only: [:new, :create]
end
