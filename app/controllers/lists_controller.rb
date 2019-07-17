class ListsController < ApplicationController
  before_action :set_project

  def create
    @list = @project.lists.build(list_params)

    if @list.save
      redirect_to project_path @project
    else
      render template: 'projects/show', 
             locals: { project: @project,
                       list: @list }
    end
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end
end
