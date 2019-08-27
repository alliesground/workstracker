class List < ApplicationRecord
  include PublicActivity::Model
  include ActivityMessageBroadcaster

  tracked owner: ->(controller, model) { controller&.current_user }

  belongs_to :project

  has_many :tasks

  validates_presence_of :title

  scope :persisted, -> { where "id IS NOT NULL" } 

  private

  def broadcast_to
    yield(project) if block_given?
  end

  def activity_message
    "Something happend to List"
  end

end
