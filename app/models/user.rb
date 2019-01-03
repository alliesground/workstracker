class User < ApplicationRecord
  include Gravtastic

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  gravtastic

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships, dependent: :destroy

  has_many :invitations, dependent: :destroy, foreign_key: :inviter_id
end
