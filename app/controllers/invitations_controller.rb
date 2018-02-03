class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_pending_invitation, only: :create
  before_action :check_invitation_to_owner, only: :create

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

  def check_invitation_to_owner
    if current_project.owner_email.eql?(invitation_params[:recipient_email])
      flash[:alert] = "You cannot invite the owner of this project."
      redirect_to current_project
    end
  end

  def check_pending_invitation
    if pending_invitation.present?
      flash[:alert] = "The invitation to this user for this project is pending."
      redirect_to current_project
    end
  end

  def pending_invitation
    Invitation.find_by(
      recipient_email: invitation_params[:recipient_email],
      resource_id: current_project.id,
      status: 'pending'
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
