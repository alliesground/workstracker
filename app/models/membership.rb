class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_one :membership_role

  after_create :assign_default_membership_role

  private

  def assign_default_membership_role
    create_membership_role
  end
end
