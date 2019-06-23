class Project < ApplicationRecord
  validates_presence_of :title

  belongs_to :owner, class_name: 'User'

  has_many :memberships, as: :resource, dependent: :destroy
  has_many :members, through: :memberships, :source => :user

  def stakeholders
    Stakeholder.all_scoped_to(resource: self)
  end
end
