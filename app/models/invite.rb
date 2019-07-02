class Invite < ApplicationRecord
  include Tokenable

  belongs_to :invitable, polymorphic: true
  belongs_to :sender, class_name: 'User'

  validates_presence_of :email

  validate :existing_invitable_member_cannot_be_invited

  validates_uniqueness_of :email, scope: :invitable, message: 'This user has already been invited', if: Proc.new { |invite| invite.errors[:email].empty? } 

  def deliver
    InviteMailWorker.perform_async(self.id)
  end 

  def resolve_for(recipient)
    recipient.memberships.create(resource_type: invitable_type,
                                 resource_id: invitable_id)

    update_columns(token: nil, recipient_id: recipient.id)
  end

  private

  def existing_invitable_member_cannot_be_invited
    if invitable.has_member_with_email?(email)
      errors.add(:email, "This #{invitable_type} already has a member with this email") 
    end
  end
end
