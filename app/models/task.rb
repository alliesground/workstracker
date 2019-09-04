class Task < ApplicationRecord
  include PublicActivity::Model
  include ActivityMessageBroadcaster

  delegate :project, to: :list

  tracked owner: ->(controller, model) { controller&.current_user }

  belongs_to :list

  has_many :assignments, dependent: :destroy
  has_many :members, through: :assignments, :source => :user
  has_many :todos, dependent: :destroy

  after_commit :broadcast, on: :create

  validates_presence_of :title

  private

  def activity_message
    "#{activity_owner_email} added Task: #{title} to #{list.title}"
  end

  def broadcast
    TasksChannel.broadcast_to(
      list,
      response: json_api_response
    )
  end

  def json_api_response
    JSONAPI::ResourceSerializer.new(TaskResource).
      serialize_to_hash(TaskResource.new(self, nil))
  end
end
