class Api::V1::ProjectsController < ApiController
  def index
    render json: current_api_user.projects
  end

  def create
    @project = current_api_user.projects.build(project_params)
    if @project.save
      render json: @project, status: :created
    else
      render_error resource:@project, status: 422
    end
  end

  private

  def project_params
    ActiveModelSerializers::Deserialization
      .jsonapi_parse(params, only: [:title, :description])
  end
end
