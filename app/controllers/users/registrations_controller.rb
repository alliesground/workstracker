class Users::RegistrationsController < Devise::RegistrationsController
  #respond_to :json

  def new_with_invite_token
    if invite.present?
      session[:invite_id] = invite.id
      store_redirect_location_to_invitable

      @user = User.new(email: invite.email)
      render :new
    else
      flash[:alert] = 'token expired'
      redirect_to expired_token_path
    end
  end

  def create
    super
  end

  private

  def store_redirect_location_to_invitable
    store_location_for(:user, url_for(invite.invitable))
  end

  def invite
    unless params[:token].nil?
      @invite ||= Invite.find_by(token: params[:token])
    end
  end
end
