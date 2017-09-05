class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = User.find_by(id: params[:id])
    unless user == current_user
      redirect_to root_path, alert: "Access denied"
    end

    @user_profile = UserProfile.new(user)
  end
end
