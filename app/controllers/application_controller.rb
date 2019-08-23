class ApplicationController < ActionController::Base
  #before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery prepend: true

  def after_sign_in_path_for(resource)
    resource.accept_invite(session[:invite_id]) if invited_resource?
    session.delete(:invite_id)

    stored_location_for(resource) || root_path
  end

  protected

#  def configure_permitted_parameters
#    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
#  end

  private

  def invited_resource?
    session[:invite_id].present?
  end 

end
