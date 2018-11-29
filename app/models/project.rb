class Project < ApplicationRecord
  validates_presence_of :title

  has_many :memberships
  has_many :users, through: :memberships

  def stakeholders
    Stakeholder.all_scoped_to(resource: self)
  end
end
