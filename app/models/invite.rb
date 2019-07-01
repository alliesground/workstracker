class Invite < ApplicationRecord
  include Tokenable

  belongs_to :invitable, polymorphic: true
  belongs_to :sender, class_name: 'User'

  validates_presence_of :email
  validates :email, uniqueness: { scope: :invitable }

  def deliver
    InviteMailWorker.perform_async(self.id)
  end

  def resolve_for(recipient)
    recipient.memberships.create(resource_type: invitable_type,
                                 resource_id: invitable_id)

    update_columns(token: nil, recipient_id: recipient.id)
  end
end
