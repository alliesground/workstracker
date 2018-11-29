class User < ApplicationRecord
  include Gravtastic

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  gravtastic

  has_many :memberships
  has_many :projects, through: :memberships, dependent: :destroy

  has_many :invitations, dependent: :destroy, foreign_key: :inviter_id

  def has_any_role_scoped_to?(resource:)
    roles.merge(Role.scoped_to(resource_id: resource.id)).exists?
  end

  def roles_scoped_to(resource:)
    roles.merge(Role.scoped_to(resource_id: resource.id))
  end
end
