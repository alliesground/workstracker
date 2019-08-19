module Api
  module V1
    class ProjectResource < JSONAPI::Resource
      attributes :title

      has_many :lists
      has_many :members
    end
  end
end
