class TaskResource < JSONAPI::Resource
  attributes :title

  belongs_to :list
  has_many :todos
  has_many :members
  has_many :assignments
end
