class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery prepend: true

  before_action :delete_project_session, if: :project_session_active?

  def after_sign_in_path_for(user)
    session[:return_to_after_invitation_acceptance] || users_profile_path(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end
