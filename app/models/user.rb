class User < ApplicationRecord
  include Gravtastic
  gravtastic
  rolify

  has_many :projects
  has_many :invitations, dependent: :destroy, foreign_key: :inviter_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

  def has_any_role_scoped_to?(resource:)
    roles.merge(Role.scoped_to(resource_id: resource.id)).exists?
  end

  def roles_scoped_to(resource:)
    roles.merge(Role.scoped_to(resource_id: resource.id))
  end
end
