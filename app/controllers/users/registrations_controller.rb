class Users::RegistrationsController < Devise::RegistrationsController
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
    handle_invitation if invitation
  end

  private

  def handle_invitation
    if invitation
      current_user.add_role(invitation.recipient_role, scope(invitation))
      Stakeholder.create(user: current_user, resource_id: scope(invitation).id)

      invitation.update_column(:token, nil)
    end
  end

  def invitation
    @invitation ||= Invitation.find_by(token: params[:token])
  end

  def scope(invitation)
    Project.find_by(id: invitation.resource_id)
  end
end
