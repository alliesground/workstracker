class Task < ApplicationRecord
  include PublicActivity::Model
  include ActivityMessageBroadcaster

  delegate :project, to: :list

  tracked owner: ->(controller, model) { controller&.current_user }

  belongs_to :list

  has_many :assignments
  has_many :members, through: :assignments, :source => :user
  has_many :todos

  validates_presence_of :title

  private

  def activity_message
    "#{activity_owner_email} added Task: #{title} to #{list.title}"
  end
end
