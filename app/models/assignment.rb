class Assignment < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  tracked params: {
    user_email: -> (controller, model) { model.user.email },
    task_title: -> (controller, model) { model.task.title }
  }

  after_create :broadcast_activity_message
  after_destroy :broadcast_activity_message

  belongs_to :user
  belongs_to :task

  private

  def broadcast_activity_message
    ActionCable.server.broadcast 'activities',
      activity_message: activity_message
  end

  def activity_message
    case PublicActivity::Activity.last.key
    when 'assignment.create'
      activity_create_message
    when 'assignment.destroy'
      activity_destroy_message
    else
      'Message not assigned for this activity'
    end
  end

  def activity_create_message
    case activity_user_email
    when activities.last.owner.email
      "#{activities.last.owner.email} joined #{activity_task_title}"
    else
      "#{activities.last.owner.email} added #{activity_user_email} to #{activity_task_title}"
    end
  end

  def activity_destroy_message
    case activity_user_email
    when activities.last.owner.email
      "#{activity_user_email} left #{activity_task_title}"
    else
      "#{activities.last.owner.email} removed #{activity_user_email} from #{activity_task_title}"
    end
  end

  def activity_user_email
    activities.last.parameters[:user_email]
  end

  def activity_task_title
    activities.last.parameters[:task_title]
  end
end
