module ActivityMessageBroadcaster
  extend ActiveSupport::Concern

  included do
    after_commit :broadcast_activity_message
  end

  private

  def broadcast_activity_message
    broadcast_to do |channel_scope|
      ActivitiesChannel.broadcast_to(
        channel_scope,
        activity_message: activity_message,
        activity_owner_id: activities.last.owner_id 
      )
    end
  end

  def activity_owner_email
    activities.last.owner.email
  end
end
