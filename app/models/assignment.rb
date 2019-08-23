class Assignment < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  tracked params: {
    user_id: proc {|controller, model| model.user_id},
    task_id: proc {|controller, model| model.task_id}
  }

  belongs_to :user
  belongs_to :task
end
