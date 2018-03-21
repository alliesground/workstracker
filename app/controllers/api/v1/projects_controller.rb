class Api::V1::ProjectsController < ApiController
  def index
    @projects = current_user.projects
  end
end
