class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def show
    @project = Project.find(params[:id]).decorate
    set_project_session(id: @project.id)
  end
end
