class ProjectFormsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project_form = ProjectForm.new
  end

  def create
    @project_form = ProjectForm.new(project_form_params)
    
    if @project_form.save(current_user: current_user)
      flash[:success] = "New project created successfully"
      redirect_to project_path(Project.last)
    else
      render :new
    end
  end

  private

  def project_form_params
    params.require(:project_form).
      permit(:project_title,
             :repo_name,
             :repo_description)
  end
end
