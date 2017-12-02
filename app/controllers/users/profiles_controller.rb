class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by(id: params[:id])
    unless @user == current_user
      redirect_to root_path, alert: "Access denied"
    end
  end
end
