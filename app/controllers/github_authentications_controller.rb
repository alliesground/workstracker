class GithubAuthenticationsController < ApplicationController
  def new_with_invitation_token
    if @invitation = Invitation.find_by(token: params[:token])
      set_invitation_session(@invitation)
      render :new
    else
      flash[:alert] = 'token expired'
      redirect_to expired_token_path
    end
  end
end
