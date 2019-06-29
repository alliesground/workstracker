class Users::RegistrationsController < Devise::RegistrationsController
  #respond_to :json

  after_action :update_invite, only: [:create], if: :invite

  def new_with_invite_token
    if invite
      session[:return_to_after_invite_acceptance] = url_for(invite.invitable)

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

  def update_invite
    invite.update_columns(token: nil, recipient_id: current_user.id)
  end

  def invite
    unless params[:token].nil?
      @invite ||= Invite.find_by(token: params[:token])
    end
  end
end
