module Api
  module V1
    class AssignmentResource < JSONAPI::Resource
      attributes :user_id, :task_id

      singleton singleton_key: -> (context) {
        key = Assignment.where(user_id: context[:user_id], 
                               task_id: context[:task_id]).first.try(:id) 

        raise JSONAPI::Exceptions::RecordNotFound.new(nil) if key.nil?
        key
      }

      belongs_to :user
      belongs_to :task
    end
  end
end
