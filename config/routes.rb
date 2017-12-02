Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get 'ui(/:action)', controller: 'ui'
  root to: "home#index"

  #resources :users, only: :show
  namespace :users do
    resources :profiles, only: :show
  end

  get 'sign_in_with_github', to: 'github_authentications#new', as: :github_authentication
  get 'sign_in_with_github/:token', to: 'github_authentications#new_with_invitation_token', as: :github_authentication_with_token

  get 'expired_token', to: 'static_pages#invalid_token'

  resources :projects, only: :show
  resources :project_forms, only: [:new, :create]

  post 'roles' => 'roles#create'

  resources :invitations, only: [:new, :create]
end
