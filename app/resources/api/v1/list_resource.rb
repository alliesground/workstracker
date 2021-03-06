module Api
  module V1
    class ListResource < JSONAPI::Resource
      attributes :title

      belongs_to :project
      has_many :tasks
    end
  end
end
