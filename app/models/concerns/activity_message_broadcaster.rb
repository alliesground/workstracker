module ActivityMessageBroadcaster
  extend ActiveSupport::Concern

  included do
    after_commit :broadcast_activity_message
  end

  private

  def broadcast_activity_message
    ActivitiesChannel.broadcast_to(
      project,
      response: json_response,
      message: activity_message,
      ownerId: activities.last.owner_id 
    )
  end

  def json_response
    return unless class_exists?("#{self.class.name}Resource")

    JSONAPI::ResourceSerializer.new(resource_class).serialize_to_hash(resource_class.new(self, nil))
  end

  def resource_class
    "#{self.class.name.classify}Resource".constantize
  end

  def class_exists?(class_name)
    klass = Module.const_get(class_name)
    return klass.is_a?(Class)
  rescue NameError
    return false
  end

  def activity_owner_email
    activities.last.owner.email
  end
end
