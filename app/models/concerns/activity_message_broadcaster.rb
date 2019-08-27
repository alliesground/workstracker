module ActivityMessageBroadcaster
  extend ActiveSupport::Concern

  included do
    after_commit :broadcast_activity_message
  end

  private

  def broadcast_activity_message
    ActivitiesChannel.broadcast_to(
      project,
      activity_message: activity_message,
      activity_owner_id: activities.last.owner_id 
    )
  end

  def activity_owner_email
    activities.last.owner.email
  end
end
