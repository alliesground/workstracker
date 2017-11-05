class RolesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.add_role params[:role]
    redirect_to current_user
  end
end
