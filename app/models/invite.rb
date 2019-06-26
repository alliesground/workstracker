class Invite < ApplicationRecord
  belongs_to :invitable, polymorphic: true
  belongs_to :sender, class_name: 'User'

  validates_presence_of :email

  def deliver
    InviteMailer.notification(self).deliver
  end
end
