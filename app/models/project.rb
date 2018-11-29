class Project < ApplicationRecord
  resourcify

  after_create :assign_owner

  validates_presence_of :title

  has_many :memberships
  has_many :users, through: :memberships

  def stakeholders
    Stakeholder.all_scoped_to(resource: self)
  end

  def owner_email
    user.email 
  end

  private

  def assign_owner
    user.add_role('owner', self)
  end
end
