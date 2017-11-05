class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      if @user.roles.blank?
        sign_in @user
        redirect_to choose_role_path and return
      end

      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to root_path, flash: { erros: 'Authentication failed' }
    end
  end

  def failure
    redirect_to root_path
  end
end
