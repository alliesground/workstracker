class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.all
    respond_to do |format|
      format.json { render( status: 200,
                            json: @projects) }
    end
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find_by(id: params[:id])

    if @project
      if current_user.has_any_role_scoped_to?(resource: @project)
        set_project_session(id: @project.id)
        @project
      else
        redirect_to root_url, notice: "You are not authorized to access this page"
      end
    else
      redirect_to root_url, notice: "This project does not exist"
    end
  end

  def create
    @project = current_user.projects.build(project_params)
    
    if @project.save
      flash[:success] = "New project created successfully"
      redirect_to project_path @project
    else
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
