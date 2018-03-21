Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :projects, only: [:index]
    end
  end

  devise_for :users, :controllers => {
    :sessions => "users/sessions",
    :registrations => "users/registrations"
  }, defaults: { format: :json }

  devise_scope :user do
    get '/users/sign_up_with_token/:token', to: 'users/registrations#new_with_invitation_token', as: :new_user_registration_with_token
  end

  get 'ui(/:action)', controller: 'ui'
  root to: "home#index"

  namespace :users do
    resources :profiles, only: :show
  end

  get 'expired_token', to: 'static_pages#invalid_token'

  resources :projects, only: [:index, :show, :new, :create]
  scope 'api' do
    get '/projects' => 'projects#index'
  end

  resources :project_forms, only: [:new, :create]

  post 'roles' => 'roles#create'

  resources :invitations, only: [:new, :create]
end
