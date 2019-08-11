module Api
  module V1
    class TodoResource < JSONAPI::Resource
      attributes :title, :completed

      belongs_to :task
    end
  end
end
