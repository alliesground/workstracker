class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def show
    @project = Project.find(params[:id])
    session[:project_id] = @project.id
  end
end
