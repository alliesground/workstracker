module Api
  module V1
    class UserResource < JSONAPI::Resource
      attributes :email

      has_many :tasks
      has_many :projects
      has_many :assignments
    end
  end
end
