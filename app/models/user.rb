class User < ApplicationRecord
  include Gravtastic

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  gravtastic

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships, source: :resource, source_type: 'Project', dependent: :destroy, before_add: :add_owner

  has_many :invitations, dependent: :destroy, foreign_key: :inviter_id

  private

  def add_owner(project)
    project.owner_id = id
  end
end
