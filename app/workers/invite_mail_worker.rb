class InviteMailWorker
  include Sidekiq::Worker
  sidekiq_option retry: false

  def perform(invite_id)
    invite = Invite.find_by_id(invite_id)
    InviteMailer.notification(invite).deliver if invite.present?
  end
end
