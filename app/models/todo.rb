class Todo < ApplicationRecord
  belongs_to :task

  validates_presence_of :title
end
