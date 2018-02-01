class Invitation < ApplicationRecord
  include Tokenable

  belongs_to :inviter, class_name: 'User'
  enum recipient_role: { client: 0, collaborator: 1 }
  enum status: { pending: 0, accepted: 1, expired: 2 }

  VALID_EMAIL_REGEXP = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i

  validates_presence_of :recipient_name,
                        :recipient_email,
                        :recipient_role,
                        :message

  validates :recipient_email, length: { maximum: 255 },
                             format: { with: VALID_EMAIL_REGEXP },
                             uniqueness: { scope: :resource_id, case_sensitive: false }
end
