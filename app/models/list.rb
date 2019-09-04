class List < ApplicationRecord
  include PublicActivity::Model
  include ActivityMessageBroadcaster

  tracked owner: ->(controller, model) { controller&.current_user }

  belongs_to :project

  has_many :tasks, dependent: :destroy

  validates_presence_of :title

  scope :persisted, -> { where "id IS NOT NULL" } 

  after_commit :broadcast, on: :create

  private

  def activity_message
    "#{activity_owner_email} added List: #{title}"
  end

  def broadcast
    ListsChannel.broadcast_to(
      project,
      response: json_api_response
    )
  end

  def json_api_response
    JSONAPI::ResourceSerializer.new(ListResource).
      serialize_to_hash(ListResource.new(self, nil))
  end
end
