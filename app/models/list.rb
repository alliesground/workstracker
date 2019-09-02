class List < ApplicationRecord
  include PublicActivity::Model
  include ActivityMessageBroadcaster

  tracked owner: ->(controller, model) { controller&.current_user }

  belongs_to :project

  has_many :tasks

  validates_presence_of :title

  scope :persisted, -> { where "id IS NOT NULL" } 

  private

  def activity_message
    "#{activity_owner_email} added List: #{title}"
  end

end
