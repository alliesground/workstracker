class List < ApplicationRecord
  belongs_to :project

  has_many :tasks

  validates_presence_of :title

  scope :persisted, -> { where "id IS NOT NULL" }
end
