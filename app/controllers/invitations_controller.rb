class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_invitation, only: :create

  skip_before_action :delete_project_session, only: [:new, :create]

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = current_user.invitations.build(
      invitation_params.merge(resource_id: current_project.id)
    )

    if @invitation.save
      UserMailer.send_project_invitation(@invitation).deliver
      flash[:success] = "Invitation sent"
      redirect_to current_project
    else
      render :new
    end
  end

  private

  def check_invitation
    if invitation.present?
      @invitation = Invitation.new(
        recipient_email: invitation_params[:recipient_email]
      )

      flash[:warning] = "This user has already been invited to this project as a #{invitation_params[:recipient_role]}"
      redirect_to current_project
    end
  end

  def invitation
    Invitation.find_by(
      recipient_email: invitation_params[:recipient_email],
      recipient_role: invitation_params[:recipient_role],
      resource_id: current_project.id
    )
  end

  def invitation_params
    params.require(:invitation).permit(
      :recipient_name,
      :recipient_email,
      :recipient_role,
      :message
    )
  end
end
