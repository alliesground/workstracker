class Api::V1::ProjectsController < ApiController
  def index
    render json: current_api_user.projects
  end

  def create
    @project = current_api_user.projects.create(project_params)

    if @project.persisted?
      render json: @project, status: :created
    else
      render_error resource: @project, status: 422
    end
  end

  def show
    project = Project.find_by(id: params[:id])

    if project
      if current_api_user.has_any_role_scoped_to?(resource: project)
        render json: project, status: 200
      else
        render json: { errors: [{detail: 'Sorry, you are not authoirized to access this resource'}] }, status: 401
      end
    else
      render json: { errors: [{detail: 'This project does not exist'}] }, status: 404
    end
  end

  private

  def project_params
    ActiveModelSerializers::Deserialization
      .jsonapi_parse(params, only: [:title, :description])
  end
end
