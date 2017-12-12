module SessionsHelper
  def set_project_session(id:)
    session[:project_id] = id
  end

  def current_project
    @project ||= Project.find_by(id: session[:project_id])
  end

  def project_session_active?
    !current_project.nil?
  end

  def delete_project_session
    session.delete(:project_id)
    @project = nil
  end
end
