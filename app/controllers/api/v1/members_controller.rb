class Api::V1::MembersController < ApiController
  parent_resources :project

  def index
    render json: parent_object.users
  end
end
