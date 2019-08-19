Rails.application.routes.draw do
  root to: 'pages#home'

  namespace :users do
    resources :profiles, only: :show
  end

  devise_for :users, :controllers => {
    :sessions => "users/sessions",
    :registrations => "users/registrations"
  }

  devise_scope :user do
    get '/users/sign_up_with_token/:token', to: 'users/registrations#new_with_invite_token', as: :new_user_registration_with_token
  end

  get 'ui(/:action)', controller: 'ui'


  resources :projects, only: [:index, :show, :new, :create] do
    resources :lists, only: :create
  end
  get 'lists/:list_id/tasks/new', to: 'tasks#new', as: 'new_task'
  post 'lists/:list_id/tasks', to: 'tasks#create', as: 'list_tasks'
  resources :tasks, only: :show

  resources :project_forms, only: [:new, :create]

  post 'roles' => 'roles#create'

  resources :invitations, only: [:new, :create]
  resources :invites, only: [:create]

  get 'pages/*page' => 'pages#show'
  post 'quiz' => 'pages#create'

  namespace :api do
    #mount_devise_token_auth_for 'User', at: 'auth'
    namespace :v1 do
#      resources :projects, only: [:index, :create, :show] do
#        resources :members, only: :index
#      end
#      resources :profiles, only: [:index]

      jsonapi_resources :projects
      jsonapi_resources :lists
      jsonapi_resources :tasks do
        jsonapi_related_resources :members
        jsonapi_related_resources :todos
      end
      jsonapi_resources :todos do
        jsonapi_related_resource :task
      end
      jsonapi_resources :users do
        jsonapi_related_resources :tasks
      end
    end
  end
end
