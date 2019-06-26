class Invite < ApplicationRecord
  belongs_to :invitable, polymorphic: true
  belongs_to :sender, class_name: 'User'

  validates_presence_of :email
end
