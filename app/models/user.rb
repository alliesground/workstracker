class User < ApplicationRecord
  rolify
  after_create :assign_role

  has_one :github_profile
  has_many :projects

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  delegate :access_token, :to => :github_profile, :prefix => true

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end

    create_github_profile(user, auth) if user.github_profile.nil?

    user
  end

  def role=(role)
    @role = role
  end

  def role
    @role
  end

  private

  def self.create_github_profile(user, auth)
    user.create_github_profile(
      access_token: auth[:credentials][:token]
    )
  end

  def assign_role
    self.add_role role
  end

end
