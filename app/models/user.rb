class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  include DeviseTokenAuth::Concerns::User
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Gravtastic
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

  def jwt_payload
    super
  end
end
