Rails.application.routes.draw do
  root to: 'pages#home'

  namespace :users do
    resources :profiles, only: :show
  end

  devise_for :users, :controllers => {
    :sessions => "users/sessions",
    :registrations => "users/registrations"
  }

#  devise_scope :user do
#    get '/users/sign_up_with_token/:token', to: 'users/registrations#new_with_invitation_token', as: :new_user_registration_with_token
#  end

  get 'ui(/:action)', controller: 'ui'


  resources :projects, only: [:index, :show, :new, :create] 

  resources :project_forms, only: [:new, :create]

  post 'roles' => 'roles#create'

  resources :invitations, only: [:new, :create]

  get 'pages/*page' => 'pages#show'
  post 'quiz' => 'pages#create'

  namespace :api do
    #mount_devise_token_auth_for 'User', at: 'auth'
    scope module: :v1 do
      resources :projects, only: [:index, :create, :show] do
        resources :members, only: :index
      end
      resources :profiles, only: [:index]
    end
  end
end
