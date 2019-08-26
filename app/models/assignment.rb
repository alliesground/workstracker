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

  def task
    task ||= Task.find_by_id(task_id)
  end

  private

  def broadcast_activity_message
    ActivitiesChannel.broadcast_to(
      task.list.project,
      activity_message: activity_message,
      activity_owner_id: activities.last.owner_id 
    )
  end

  def show_refresh?
  end

  def activity_message
    case activity_user_email
    when activity_owner_email
      "#{activity_owner_email} #{key == 'create' ? 'joined' : 'left'} #{activity_task_title}"
    else
      "#{activity_owner_email} #{key == 'create' ? 'added' : 'removed'} #{activity_user_email} #{key == 'create' ? 'to' : 'from'} #{activity_task_title}"
    end
  end

  def key
    PublicActivity::Activity.last.key.split('.').last
  end

  def activity_owner_email
    activities.last.owner.email
  end

  def activity_user_email
    activities.last.parameters[:user_email]
  end

  def activity_task_title
    activities.last.parameters[:task_title]
  end
end
