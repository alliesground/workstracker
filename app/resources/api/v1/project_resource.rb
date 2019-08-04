module Api
  module V1
    class ProjectResource < JSONAPI::Resource
      attributes :title

      has_many:lists
    end
  end
end
