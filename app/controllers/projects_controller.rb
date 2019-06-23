class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find_by(id: params[:id])

    unless @project.present?
      redirect_to root_url, notice: "This project does not exist" and return
    end

    unless @project.members.include? current_user
      redirect_to root_url, notice: "You are not authorized to access this page" and return
    end

    @project
  end

  def create
    @project = current_user.projects.create(project_params)

    if @project.persisted?
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
