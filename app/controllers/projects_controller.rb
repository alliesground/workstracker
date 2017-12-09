class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def show
    @project = current_user.projects.find_by(id: params[:id])
    if @project
      @project.decorate
      set_project_session(id: @project.id)
    else
      redirect_to root_url, notice: "You are not authorized to access this page"
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
