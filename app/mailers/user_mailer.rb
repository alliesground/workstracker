class UserMailer < ApplicationMailer
  def send_project_invitation(project_invitation)
    @project_invitation = project_invitation
    @project = Project.to_join(id: @project_invitation.resource_id).first

    mail(from: @project_invitation.inviter.email,
         to: @project_invitation.recipient_email,
         subject: "Invitation to join #{@project.title}")
  end
end
