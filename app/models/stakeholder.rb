class Stakeholder < ApplicationRecord
  belongs_to :user

  delegate :email, :to => :user
  delegate :roles_scoped_to, :to => :user

  def self.all_scoped_to(resource:)
    where(resource_id: resource.id)
  end
end
