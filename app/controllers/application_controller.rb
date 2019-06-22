class ApplicationController < ActionController::Base
  #include SessionsHelper

  #before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery prepend: true

  #before_action :delete_project_session, if: :project_session_active?

  protected 

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end
