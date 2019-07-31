class User < ApplicationRecord
  include Gravtastic

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  gravtastic

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships, source: :resource, source_type: 'Project', dependent: :destroy, before_add: :add_owner

  has_many :invitations, dependent: :destroy, foreign_key: :inviter_id

  has_many :invites, dependent: :destroy, foreign_key: :sender_id

  has_many :assignments, dependent: :destroy
  has_many :tasks, through: :assignments

  def accept_invite(invite_id)
    invite = Invite.find_by_id(invite_id)
    invite.resolve_for(self) if invite.present?
  end

  private

  def add_owner(project)
    project.owner_id = id
  end
end
