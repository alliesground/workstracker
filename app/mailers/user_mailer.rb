class UserMailer < ApplicationMailer
  def send_project_invitation(project_invitation)
    @project_invitation = project_invitation

    mail(from: @project_invitation.inviter.email,
         to: @project_invitation.recipient_email,
         subject: "Invitation to join #{Project.title_for(id: @project_invitation.resource_id)}")
  end
end
