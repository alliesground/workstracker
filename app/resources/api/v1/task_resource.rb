module Api
  module V1
    class TaskResource < JSONAPI::Resource
      attributes :title

      belongs_to :list
    end
  end
end
