class Assignment < ApplicationRecord
  include PublicActivity::Model
  include ActivityMessageBroadcaster

  delegate :project, to: :task
  delegate :email, to: :user, prefix: true
  delegate :title, to: :task, prefix: true

  tracked owner: ->(controller, model) { controller&.current_user } 

  belongs_to :user
  belongs_to :task

  after_commit :message_for_create, on: :create
  after_commit :message_for_destroy, on: :destroy

  def task
    task ||= Task.find_by_id(task_id)
  end

  private

  def activity_message
    transaction_include_any_action?([:create]) ? 
      message_for_create :
      message_for_destroy
  end

  def message_for_create
    case user_email
    when activity_owner_email
      "#{activity_owner_email} joined #{task_title}"
    else
      "#{activity_owner_email} added #{user_email} to #{task_title}"
    end
  end

  def message_for_destroy
    case user_email
    when activity_owner_email
      "#{activity_owner_email} left #{task_title}"
    else
      "#{activity_owner_email} removed #{user_email} from #{task_title}"
    end
  end

end
