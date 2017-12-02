class InvitationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :delete_project_session, only: [:new, :create]

  def new
    @invitation = Invitation.new
  end

  def create
    params[:invitation].merge!(resource_id: current_project.id)
    @invitation = current_user.invitations.build(invitation_params)

    if @invitation.save
      UserMailer.send_project_invitation(@invitation).deliver
      flash[:success] = "Invitation sent"
      redirect_to current_project
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
