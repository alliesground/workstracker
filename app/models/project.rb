class Project < ApplicationRecord
  after_commit :assign_default_membership_role, on: :create

  validates_presence_of :title

  has_many :memberships
  has_many :users, through: :memberships

  def stakeholders
    Stakeholder.all_scoped_to(resource: self)
  end

  private

  def assign_default_membership_role
    memberships.last.create_membership_role
  end
end
