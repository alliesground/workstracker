class Assignment < ApplicationRecord
  include PublicActivity::Common

  after_create :activity_create, :broadcast_create
  before_destroy :activity_create, :broadcast_destroy

  belongs_to :user
  belongs_to :task

  private

  def activity_create
    self.activity_owner = proc {|controller| controller.current_user }
    self.create_activity :create
  end

  def broadcast_create
    activity = case user
               when activities.last.owner
                 "#{activities.last.owner.email} joined #{task.title}"
               else
                 "#{activities.last.owner.email} added #{user.email} to #{task.title}"
               end

    ActionCable.server.broadcast 'activities',
      activity: activity
  end

  def broadcast_destroy
  end
end
