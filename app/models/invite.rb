class Invite < ApplicationRecord
  include Tokenable

  belongs_to :invitable, polymorphic: true
  belongs_to :sender, class_name: 'User'

  validates_presence_of :email

  def deliver
    InviteMailWorker.perform_async(self.id)
  end
end
