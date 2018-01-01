class Project < ApplicationRecord
  resourcify

  after_create :assign_owner

  validates_presence_of :title

  belongs_to :user

  def self.title_for(id:)
    where(id: id).pluck(:title).first
  end

  def stakeholders
    Stakeholder.all_scoped_to(resource: self)
  end

  private

  def assign_owner
    user.add_role('owner', self)
  end
end
