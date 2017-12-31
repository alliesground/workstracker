class Project < ApplicationRecord
  resourcify

  after_create :assign_owner, :assign_stakeholder

  validates_presence_of :title

  belongs_to :user

  def self.to_join(id:)
    select('title').where(id: id).limit(1)
  end

  def stakeholders
    Stakeholder.all_scoped_to(resource: self)
  end

  private

  def assign_owner
    user.add_role('owner', self)
  end

  def assign_stakeholder
    Stakeholder.create(user: user, resource_id: self.id)
  end
end
