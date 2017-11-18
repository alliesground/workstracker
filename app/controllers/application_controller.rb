class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :delete_project_session, if: :project_session_on?

  def after_sign_in_path_for(user)
    user_path(user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  def delete_project_session
    session.delete(:project_id)
  end

  def project_session_on?
    session[:project_id].present?
  end
end
