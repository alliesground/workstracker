class TasksController < ApplicationController
  before_action :setup_list, only: [:new, :create]

  def new
    @task = @list.tasks.build
  end

  def create
    @task = @list.tasks.build(list_params)

    if @task.save
      redirect_to project_path @list.project
    else
      render :new
    end
  end

  def show
  end

  private

  def setup_list
    @list = List.find_by(id: params[:list_id])
  end

  def list_params
    params.require(:task).permit(:title, :description)
  end
end
