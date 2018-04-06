class Api::V1::ProjectsController < ApiController
  def index
    render json: current_user.projects
  end
end
