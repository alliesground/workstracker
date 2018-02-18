class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  after_action :handle_invitation, only: [:create], if: :invitation

  def new_with_invitation_token
    if invitation
      session[:return_to_after_invitation_acceptance] = url_for(scope(invitation))

      @user = User.new(email: invitation.recipient_email)
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

  def handle_invitation
    if invitation
      current_user.add_role(invitation.recipient_role, scope(invitation))
      invitation.update_columns(token: nil, recipient_id: current_user.id)
    end
  end

  def invitation
    unless params[:token].nil?
      @invitation ||= Invitation.find_by(token: params[:token])
    end
  end

  def scope(invitation)
    Project.find_by(id: invitation.resource_id)
  end
end
