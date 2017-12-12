Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => "users/registrations"
  }

  devise_scope :user do
    get '/users/sign_up_with_token/:token', to: 'users/registrations#new_with_invitation_token', as: :new_user_registration_with_token
  end

  get 'ui(/:action)', controller: 'ui'
  root to: "home#index"

  namespace :users do
    resources :profiles, only: :show
  end

  get 'expired_token', to: 'static_pages#invalid_token'

  resources :projects, only: [:show, :new, :create]
  resources :project_forms, only: [:new, :create]

  post 'roles' => 'roles#create'

  resources :invitations, only: [:new, :create]
end
