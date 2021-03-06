class Project < ApplicationRecord
  include Invitable

  validates_presence_of :title

  belongs_to :owner, class_name: 'User'

  has_many :memberships, as: :resource, dependent: :destroy
  has_many :members, through: :memberships, :source => :user

  has_many :invites, as: :invitable, dependent: :destroy

  has_many :lists
end
