module SessionsHelper
  def set_invitation_session(invitation)
    session[:invitation_id] = invitation.id
  end

  def current_invitation
    @invitation ||= Invitation.find_by(id: session[:invitation_id])
  end

  def invitation_session_active?
    !current_invitation.nil?
  end

  def delete_invitation_session
    session.delete(:invitation_id)
    @invitation = nil
  end

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
