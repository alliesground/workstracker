class Api::V1::ProjectsController < ApiController
  def index
    render json: current_user.projects
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      render json: @project, status: :created
    else
      render json: { errors: @project.errors }, status: 422
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
