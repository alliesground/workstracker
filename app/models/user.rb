class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  include Gravtastic

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable

  gravtastic
  rolify

  has_many :projects
  has_many :invitations, dependent: :destroy, foreign_key: :inviter_id

  def has_any_role_scoped_to?(resource:)
    roles.merge(Role.scoped_to(resource_id: resource.id)).exists?
  end

  def roles_scoped_to(resource:)
    roles.merge(Role.scoped_to(resource_id: resource.id))
  end
end
