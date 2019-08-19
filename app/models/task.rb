class Task < ApplicationRecord
  belongs_to :list

  has_many :assignments
  has_many :members, through: :assignments, source: :user
  has_many :todos

  validates_presence_of :title
end
