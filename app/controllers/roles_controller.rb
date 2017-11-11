class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_role

  def create
    current_user.add_role params[:role]
    redirect_to current_user
  end

  private

  def check_role
    unless current_user.roles.blank?
      flash[:notice] = "You already have an active role"
      redirect_to user_path current_user
    end
  end
end
