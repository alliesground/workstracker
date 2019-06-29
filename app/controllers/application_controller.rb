class ApplicationController < ActionController::Base
  #include SessionsHelper

  #before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery prepend: true

  def after_sign_in_path_for(resource)
    binding.pry
    stored_location_for(resource) || welcome_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end
