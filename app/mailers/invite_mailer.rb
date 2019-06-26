class InviteMailer < ApplicationMailer
  def notification(invite)
    @invite = invite
    mail(to: invite.email, subject: 'Invitation')
  end
end
