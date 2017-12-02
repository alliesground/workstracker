class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :delete_invitation_session

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      @user.add_role(current_invitation.recipient_role, project) if invitation_session_active?

      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to root_path, flash: { erros: 'Authentication failed' }
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def project
    Project.find(current_invitation.resource_id)
  end
end
