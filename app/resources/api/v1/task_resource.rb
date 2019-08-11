module Api
  module V1
    class TaskResource < JSONAPI::Resource
      attributes :title

      belongs_to :list
      has_many :todos
    end
  end
end
