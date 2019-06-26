# Preview all emails at http://localhost:3000/rails/mailers/invite_mailer
class InviteMailerPreview < ActionMailer::Preview
  def notification_preview
    InviteMailer.notification(Invite.find(5))
  end
end
