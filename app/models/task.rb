class Task < ApplicationRecord
  belongs_to :list

  has_many :assignments
  has_many :users, through: :assignments

  validates_presence_of :title
end
