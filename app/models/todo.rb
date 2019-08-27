class Todo < ApplicationRecord
  include PublicActivity::Model
  include ActivityMessageBroadcaster

  belongs_to :task

  delegate :project, to: :task
  delegate :title, to: :list, prefix: :list

  validates_presence_of :title

  tracked owner: ->(controller, model) { controller&.current_user }

  after_commit :message_for_update, on: :update

  private

  def message_for_update
    if previous_changes['completed']&.any?
      if completed?
        <<-message
          #{activity_owner_email} completed 
          #{title} on #{task.title}
        message
      else
        <<-message
          #{activity_owner_email} marked 
          #{title} incomplete on #{task.title}
        message
      end
    else
      "There were some changes made"
    end
  end

  def activity_message
    message_for_update
  end

  def list
    @list ||= task.list
  end
end
