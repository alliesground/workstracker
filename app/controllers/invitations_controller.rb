class InvitationsController < ApplicationController
  skip_before_action :delete_project_session, only: [:new, :create]

  def new
    @invitation = Invitation.new
  end

  def create
    params[:invitation].merge!(resource_id: session[:project_id])
    @invitation = current_user.invitations.build(invitation_params)

    if @invitation.save
      flash[:success] = "Invitation sent"
      redirect_to project_path @invitation.resource_id
    else
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(
      :recipient_name,
      :recipient_email,
      :recipient_role,
      :message,
      :inviter_id,
      :resource_id
    )
  end
end
